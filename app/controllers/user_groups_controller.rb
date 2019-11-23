class UserGroupsController < ApplicationController
  # TODO: this may actually be better placed within the GroupsController
  # DELETE /groups/:id/members/:member_id
  def delete_member
    group_id = params[:id]
    @member_to_delete = UserGroup.find_by!(group_id: params[:id], user_id: params[:member_id])
    removed_member_email = @member_to_delete.user.email
    @member_to_delete.destroy

    respond_to do |format|
      format.html { redirect_to group_url(group_id), notice: "#{removed_member_email} was successfully removed" }
    end
  end
end
