class GroupsController < ApplicationController
    def index
        redirect_to root_path if no_current_user
        if current_user
            @my_groups = User.find(current_user.id).groups
            if params[:group]
                @group = Group.find(params[:group])
            end
        end
    end
    def create
        if Group.where(group_params).length > 0
            flash[:errors] = ["Group already exists"]
        else
            new_group = User.find(current_user.id).groups.new(group_params)
            if new_group.save
                User.find(current_user.id).joins.create(group: new_group)
            else
                flash[:errors] = new_group.errors.full_messages
            end
        end
        redirect_to groups_path
    end
    def find
        if Group.find_by(name: params[:group_name])
            group = Group.find_by(name: params[:group_name])
            redirect_to groups_path(group: group)
        else
            flash[:errors] = ["COULD NOT FIND GROUP"]
            redirect_to groups_path
        end
    end
    def destroy
        Group.find(params[:group_id]).destroy
        redirect_to groups_path
    end
    def show
        redirect_to root_path if no_current_user
        if current_user
            @group = Group.find(params[:group_id])
            @high_score = @group.users_joined.first.picks.where(correct: true).count
            @high_scorer = @group.users_joined.first.username
            @group.users_joined.each do |user|
                if user.picks.where(correct: true).count > @high_score
                    @high_score = user.picks.where(correct: true).count
                    @high_scorer = user.username
                end
            end
        end
    end
    def join
        User.find(current_user.id).joins.create(group:Group.find(params[:group_id]))
        redirect_to groups_path
    end
    def leave
        User.find(current_user.id).joins.find_by(group:Group.find(params[:group_id])).destroy
        redirect_to groups_path
    end
    private
    def group_params
        params.require(:group).permit(:name)
    end
end
