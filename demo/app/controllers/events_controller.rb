class EventsController < ApplicationController

  before_filter :find_event, :only => [ :show, :edit, :update, :destroy]


  def index
#    @events = Event.all
    @events = Event.page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end


  def new
    @event = Event.new
  end


  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "event was successfully created"
      #redirect_to :action => :index
      redirect_to events_path
    else
      render :action => :new
    end
  end


  def show
    @page_title = @event.name

    Rails.logger.debug("event: #{@event.inspect}")

    respond_to do |format|
      format.html
      format.xml
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end


  def edit
  end


  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "event was successfully updated"
      #redirect_to :action => :show, :id => @event
      redirect_to event_url(@event)
    else
      render :action => :edit
    end
  end


  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"
    #redirect_to :action => :index
    redirect_to events_path
  end


  protected

  def find_event
    @event = Event.find(params[:id])
  end

end
