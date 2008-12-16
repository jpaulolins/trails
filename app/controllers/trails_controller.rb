class TrailsController < ApplicationController
  before_filter :login_required
  # GET /trails
  # GET /trails.xml
  def index
    @trails = current_user.trails
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @trails.to_xml }
    end
  end

  # GET /trails/1
  # GET /trails/1.xml
  def show
    @trail = Trail.find(params[:id])
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @points = @trail.points
    @map.center_zoom_init([@points[0].lg, @points[0].lt],15)
    mypoints = Array.new
    @map.overlay_init(GMarker.new([@points[0].lg, @points[0].lt], :title => "Start", :info_window => 'zero'))
    @map.overlay_init(GMarker.new([@points[-1].lg, @points[-1].lt], :title => "End", :info_window => '10km/h'))
    for point  in @points
#      @map.overlay_init(GMarker.new([point.lg, point.lt], :title => "velocidade", :info_window => point.velocity))
#      mypoints << GLatLng.new([point.lg, point.lt])
      mypoints << [point.lg, point.lt]
    end
#    GPolyline.new([[12.4,65.6],[4.5,61.2]],"#ff0000",3,1.0)
    logger.info mypoints.inspect
    @map.overlay_init(GPolyline.new(mypoints))

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @trail.to_xml }
    end
  end

  # GET /trails/new
  def new
    @trail = Trail.new
  end

  # GET /trails/1;edit
  def edit
    @trail = Trail.find(params[:id])
  end

  # POST /trails
  # POST /trails.xml
  def create
    params[:trail][:user_id] = params[:user_id]
    @trail = Trail.new(params[:trail])

    respond_to do |format|
      if @trail.save
        flash[:notice] = 'trail was successfully created.'
        format.html { redirect_to trail_url(@trail) }
        format.xml do
            render :text => '', :status => '201 created'
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trail.errors.to_xml }
      end
    end
  end
  
  # PUT /trails/1
  # PUT /trails/1.xml
  def update
    @trail = Trail.find(params[:id])

    respond_to do |format|
      if @trail.update_attributes(params[:trail])
        flash[:notice] = 'Trail was successfully updated.'
        format.html { redirect_to trail_url(@trail) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trail.errors.to_xml }
      end
    end
  end

  # DELETE /trails/1
  # DELETE /trails/1.xml
  def destroy
    @trail = Trail.find(params[:id])
    @trail.destroy

    respond_to do |format|
      format.html { redirect_to trails_url }
      format.xml  { head :ok }
    end
  end
  
end
