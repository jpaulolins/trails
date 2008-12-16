class PointsController < ApplicationController
  before_filter :login_required
  # GET /points
  # GET /points.xml
  def index
    @points = current_user.trails.find(params[:trail_id]).points
    logger.debug params.inspect
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @points.to_xml }
    end
  end

  # GET /points/1
  # GET /points/1.xml
  def show
    @point = Point.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @point.to_xml }
    end
  end

  # GET /points/new
  def new
    @point = Point.new
  end

  # GET /points/1;edit
  def edit
    @point = Point.find(params[:id])
  end

  # POST /points
  # POST /points.xml
  def create
    logger.debug params.inspect
    params[:point] = {}
    params[:point][:trail_id] = params[:trail_id]
    params[:point][:lt] = params[:lt]
    params[:point][:lg] = params[:lg]
    params[:point][:velocity] = params[:velocity]
    @point = Point.new(params[:point])

    respond_to do |format|
      if @point.save
        flash[:notice] = 'Point was successfully created.'
        format.html { redirect_to point_url(@point) }
        format.xml do
            #{ head :created, :location => point_url(@point) }
#            headers['Location'] = device_points_url(@point)
            render :text =>  @point.id, :status => '201 created'
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @point.errors.to_xml }
      end
    end
  end
  
  # PUT /points/1
  # PUT /points/1.xml
  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        flash[:notice] = 'Point was successfully updated.'
        format.html { redirect_to point_url(@point) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @point.errors.to_xml }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.xml
  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to points_url }
      format.xml  { head :ok }
    end
  end
end
