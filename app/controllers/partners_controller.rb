# allows http requests
require 'httparty'
require 'json'

class PartnersController < ApplicationController

  def index
    @partners = Partner.all
  end

  def show
    @partner = Partner.find(params[:id])
  end

  def new
    @good = Good.find(params[:good_id])
    @partner = Partner.new
  end

  def create
    @good = Good.find(params[:good_id])
    @partner = Partner.new(partner_params)
    @partner.good = @good
    @partner.user = current_user
    if @partner.save
      # set good status
      @good.set_status
      @good.save
      if @good.status
        confirmation_email(@good)
        create_contract(@good)
      end
      redirect_to good_path(@good)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @partner.update(partner_params)
      redirect_to @partner
    else
      render :edit
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy
    redirect_to :root
  end

  private

  def partner_params
    params.permit(:track_use, :other_drivers)
  end

  def confirmation_email(good)
    @good = good
    Partner.where(good: good).each do |p|
      p.update! step: 1
      @user = User.where(id: p.user_id).first
      UserMailer.new_partnrs(@user, @good).deliver_now
    end
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
