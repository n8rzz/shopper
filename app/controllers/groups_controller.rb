# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_group_invitee, only: [:invitation, :review_invitation, :decline_invitation, :accept_invitation]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/
  def show
    @current_user_id = current_user.id
    # TODO: move this to the User model
    @pending_invites = User.where(invitation_group_id: @group.id)
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups
  # POST /groups.json
  def create
    @invitee = current_user
    @group = @invitee.groups.create(group_params)

    respond_to do |format|
      if @group.save && @invitee.save
        format.html { redirect_to groups_url, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: groups_url }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_url, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: groups_url }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /groups/invitation
  def invitation
    return redirect_to root_path unless can_review_invitation?

    redirect_to group_invitation_path(@invitee.invitation_group_id, invitation_group_token: @invitee.invitation_group_token)
  end

  # GET /groups/:id/invitation
  def review_invitation
    return redirect_to root_path unless can_review_invitation?

    render :confirm_invitation
  end

  # POST /groups/invitation
  def accept_invitation
    return redirect_to root_path unless can_review_invitation?

    invitation_group_id = @invitee.invitation_group_id
    @invitee.clear_group_invitation

    respond_to do |format|
      if @invitee.save
        format.html { redirect_to group_path(invitation_group_id), notice: 'Group invite confirmed! We are transferring ownership of your items, assemblies, locations and departments' }
      else
        format.html { redirect_to root_path, notice: 'Something went wrong processing your Group invitation' }
      end
    end
  end

  # DELETE /groups/invitation
  def decline_invitation
    return redirect_to root_path unless can_review_invitation?

    @invitee.clear_group_invitation

    respond_to do |format|
      if @invitee.save
        format.html { redirect_to orders_path, notice: 'Group invite declined sucessfully' }
      else
        format.html { redirect_to root_path, notice: 'Something went wrong processing your Group invitation' }
      end
    end
  end

  # DELETE /groups/:group_id/user/:user_id
  def delete_pending_invite
    @group = Group.find_by(id: params[:group_id])
    @pending_invitee = User.delete_pending_invite(params[:user_id])

    respond_to do |format|
      if !@pending_invitee.nil? && @pending_invitee.save
        format.html { redirect_to group_path(@group.id), notice: 'Pending User invite removed' }
      else
        format.html { redirect_to group_path(@group.id), notice: 'Pending User not found' }
      end
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_group_invitee
    @invitee = User.find_by(invitation_group_token: params[:invitation_group_token])
  end

  def group_params
    params.require(:group).permit(:name, :description, user_ids: [])
  end

  # TODO: move to user model
  def can_review_invitation?
    !@invitee.invitation_group_token.nil? && !@invitee.invitation_group_id.nil? && @invitee.email == current_user.email
  end
end
