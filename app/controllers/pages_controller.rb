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
    @partner = Partner.find_by(good: @good, user: current_user)
  end

  def contract
    head :forbidden unless @good.users.include? current_user
    Partner.find_by(good: @good, user: current_user).update! step: 2

    # create contract if all partners are confirmed
    create_contract(@good) if @good.partners.pluck(:step).uniq == ['confirmed']
  end

  private

  def set_good
    @good = Good.find(params[:good_id])
  end

  def create_contract(good)
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
              Name: "Contrato - #{good.brand} #{good.model}",
              Good: "#{good.brand} #{good.model}"
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

      # create signer's clicksign uniq hash for each user of the given good
      if p.user.clicksign_key.nil?
        p.user.clicksign_key = response['signer']['key']
        p.user.save
      end

      add_signers_to_contract(good)
    end
  end

  def add_signers_to_contract(good)
    Partner.where(good: good).each do |p|
      HTTParty.post('https://sandbox.clicksign.com/api/v1/lists?access_token=27db8324-897b-485a-9848-1e8482a60aab',
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
