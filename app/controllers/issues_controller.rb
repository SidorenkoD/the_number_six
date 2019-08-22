class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: :foo
  before_action :verify_mailgun, only: :foo

  def verify_mailgun
    # is_auth = ActionMailbox::Ingresses::Mailgun::InboundEmailsController::Authenticator.new(
    #   key:       Rails.application.credentials.action_mailbox[:mailgun_api_key],
    #   timestamp: params[:timestamp],
    #   token:     params[:token],
    #   signature: params[:signature]
    # ).authenticated?

    data_to_encode = params[:timestamp] + params[:token]
    digest         = OpenSSL::Digest.new('sha256')
    key            = Rails.application.credentials.action_mailbox[:mailgun_api_key]
    signature      = OpenSSL::HMAC.hexdigest(digest, key, data_to_encode)
    is_auth        = signature == params[:signature]

    handle_unverified_request unless is_auth
  end

  def foo
    Issue.create! title: "It's a webhook!"
  end

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:title, :content)
    end
end
