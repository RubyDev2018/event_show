class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def show
    @event = Event.find_by(id: params[:id])
    @ticket = current_user && current_user.tickets.find_by(event: @event)
    @tickets = @event.tickets.preload(:user).order(:crated_at) #1
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: "作成しました"
    end
  end

  def edit
    @event = current_user.created_events.find_by(id: params[:id])
  end

  def update
    @event = current_user.created_events.find_by(id: params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "更新しました。"
    end
  end

  def destroy
    @event = current_user.created_events.find_by(id: params[:id])
    @event.destroy!
    redirect_to root_path, alert: "削除しました。"
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :image, :remove_image, :content, :start_at, :end_at
    )
  end
end
