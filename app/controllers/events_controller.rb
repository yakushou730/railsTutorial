class EventsController < ApplicationController

	before_action :authenticate_user!, :except => [:index]
	before_action :set_event, :only => [:show, :edit, :update, :destroy, :dashboard]

	def index

		if params[:eid]
			@event = Event.find(params[:eid])
		else
			@event = Event.new
		end

		prepare_variable_for_index_template

		respond_to do |format|
			format.html	#index.html.erb
			format.xml { render :xml => @events.to_xml }
			format.json { render :json => @events.to_json }
			format.atom { @feed_title = "My event list" } # index.atom.builder
		end
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)

		@event.user = current_user

		if @event.save

			flash[:notice] = "create success"

			redirect_to events_url
		else
			prepare_variable_for_index_template

			render :action => :index
		end
	end

	# GET /events/latest
	def latest
		@events = Event.order("id DESC").limit(3)
	end

	#POST /events/bulk_update
	def bulk_update
		ids = Array(params[:ids])
		events = ids.map{|i| Event.find_by_id(i)}.compact

		if params[:commit] == "Delete"
			events.each {|e| e.destroy}
		elsif params[:commit] == "Publish"
			events.each {|e| e.update(:status => "published")}
		end

		redirect_to :back
	end

	# GET /events/:id/dashboard
	def dashboard

	end

	def show
		#@page_title = @event.name
		@event = Event.find(params[:id])
		respond_to do |format|
			format.html { @page_title = @event.name } # show.html.erb
			format.xml # show.xml.builder
			format.json { render :json => { id: @event.id, name: @event.name }.to_json }
		end
	end

	def edit

	end

	def update
		if params[:_remove_avatar] == "1"
			@event.avatar = nil
		end

		if @event.update(event_params)

			flash[:notice] = "update success"

			redirect_to events_url
		else
			prepare_variable_for_index_template

			render :action => :index
		end


	end

	def destroy
		@event.destroy

		flash[:alert] = "delete success"

		redirect_to events_url
	end

	private
	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
		params.require(:event).permit(:name, :avatar,:description, :start_time, :category_id, :status, group_ids: [])
	end

	def prepare_variable_for_index_template

		if params[:keyword]
			@events = Event.where(["name like ?", "%#{params[:keyword]}%"])
		else
			@events = Event.order("id DESC")
		end

		@q = Event.ransack(params[:q])
		@events = @q.result(distinct: true)

		if params[:order]
			sort_by = (params[:order] == "name") ? "name" : "id"
			@events = @events.order(sort_by)
		end

		@events = @events.page(params[:page]).per(5)

	end
end