class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :partnrs
  before_action :set_good, only: %i[ confirmation contract]

  def home; end

  def partnrs
    if current_user.adm?
      @goods = Good.all
    else
      @goods = current_user.goods
    end
  end

  def confirmation
    head :forbidden unless @good.users.include? current_user
    head :forbiden if current_user.partners.where(good: @good).first.step == 'confirmed' || current_user.partners.where(good: @good).first.step == 'signed'

    @partner = Partner.find_by(good: @good, user: current_user)
  end

  def contract
    head :forbidden unless @good.users.include? current_user
    Partner.find_by(good: @good, user: current_user).update! step: 2

    # create contract if all partners are confirmed
    if @good.partners.pluck(:step).uniq == ['confirmed'] && @good.clicksign_key.nil?
      create_contract(@good)
      contract_email(@good)
    end
  end

  private

  def set_good
    @good = Good.find(params[:good_id])
  end

  def create_contract(good)
    # gets all partners' data
    count = 1
    # b = binding
    Partner.where(good: good).each do |p|
      instance_variable_set("@name#{count}", "#{p.user.first_name} #{p.user.last_name}")
      instance_variable_set("@occupation#{count}", "#{p.user.occupation}")
      instance_variable_set("@cpf#{count}", "#{p.user.CPF}")
      instance_variable_set("@address#{count}", "#{p.user.address}")

      count += 1
    end

    response = HTTParty.post('https://sandbox.clicksign.com/api/v1/templates/eaa238ba-f5e9-4a29-849a-94427897c23e/documents?access_token=27db8324-897b-485a-9848-1e8482a60aab',
      headers: {
        Host: 'sandbox.clicksign.com',
        'Content-Type' => 'application/json',
        Accept: 'application/json'
      },
      body: {
        document: {
          path: "/Patnership-Contracts/#{good.brand}-#{good.model}-contract.docx",
          template: {
            data: {
              Brand: "#{good.brand}",
              Model: "#{good.model}",
              ModelY: "#{good.model_year}",
              FabricationY: "#{good.fabrication_year}",
              'Serial_Number' => "#{good.serial_number}",
              Kilometers: "#{good.kilometers}",
              Color: "#{good.color}",
              Version: "#{good.version}",
              Price: "#{good.price}",
              Day: "#{Time.now.day}",
              Month: "#{Time.now.month}",
              Year: "#{Time.now.year}",
              Name1: "#{@name1}",
              Name2: "#{@name2}",
              Name3: "#{@name3}",
              Name4: "#{@name4}",
              Occupation1: "#{@occupation1}",
              Occupation2: "#{@occupation2}",
              Occupation3: "#{@occupation3}",
              Occupation4: "#{@occupation4}",
              CPF1: "#{@cpf1}",
              CPF2: "#{@cpf2}",
              CPF3: "#{@cpf3}",
              CPF4: "#{@cpf4}",
              Address1: "#{@address1}",
              Address2: "#{@address2}",
              Address3: "#{@address3}",
              Address4: "#{@address4}"
            }
          }
        }
      }.to_json)

    # create contrac's clicksign uniq hash
    if good.clicksign_key.nil?
      good.clicksign_key = response['document']['key']
      good.save
    end

    # create signer on clicksign platform
    create_signers(@good)
  end

  def create_signers(good)
    Partner.where(good: good).each do |p|
      response = HTTParty.post('https://sandbox.clicksign.com/api/v1/signers?access_token=27db8324-897b-485a-9848-1e8482a60aab',
        headers: {
          Host: 'sandbox.clicksign.com',
          'Content-Type' => 'application/json',
          Accept: 'application/json'
        },
        body: {
          signer: {
            email: "#{p.user.email}",
            phone_number: "#{p.user.phone_number}",
            auths: [
              "sms"
            ],
            name: "#{p.user.first_name} #{p.user.last_name}",
            documentation: "#{p.user.CPF}",
            has_documentation: true
          }
        }.to_json)

      # get signer's clicksign uniq hash for each user of the given good
      if p.user.clicksign_key.nil?
        p.user.clicksign_key = response['signer']['key']
        p.user.save
      end

    end
    add_signers_to_contract(good)
  end

  def add_signers_to_contract(good)
    Partner.where(good: good).each do |p|
      response = HTTParty.post('https://sandbox.clicksign.com/api/v1/lists?access_token=27db8324-897b-485a-9848-1e8482a60aab',
        headers: {
          Host: 'sandbox.clicksign.com',
          'Content-Type' => 'application/json',
          Accept: 'application/json'
        },
        body: {
          list: {
            document_key: "#{good.clicksign_key}",
            signer_key: "#{p.user.clicksign_key}",
            sign_as: 'party'
          }
        }.to_json)

      # get signer's clicksign uniq hash for each user of the given good
      if p.request_signature_key.nil?
        p.request_signature_key = response['list']['request_signature_key']
        p.save
      end
    end
  end

  # def request_signature_key(sign = {})
  #   good = sign[:good]
  #   user = sign[:user]

  #   repsonse = HTTParty.get('https://sandbox.clicksign.com/api/v1/documents/#{good.clicksign_key}?access_token=27db8324-897b-485a-9848-1e8482a60aab',
  #     headers: {
  #       Host: 'sandbox.clicksign.com',
  #       'Content-Type' => 'application/json',
  #       Accept: 'application/json'
  #     }

  #   # request_signature_key
  #   @key = response['signers']['key']
  # end

  def contract_email(good)
    @good = good
    @good.users.each do |user|
      @user = user
      UserMailer.contract_ready(@user, @good).deliver_now
    end
  end
  # def delete_signer_from_contract(good)
  #   Partner.where(good: good).each do |p|
  #     HTTParty.delete('https://sandbox.clicksign.com/api/v1/lists?access_token=27db8324-897b-485a-9848-1e8482a60aab',
  #       headers: {
  #         Host: 'sandbox.clicksign.com',
  #         'Content-Type' => 'application/json',
  #         Accept: 'application/json'
  #       },
  #       body: {
  #         list: {
  #           document_key: "#{good.clicksign_key}",
  #           signer_key: "#{p.user.clicksign_key}",
  #           sign_as: 'party'
  #         }
  #       }.to_json)
  #   end
  # end
end
