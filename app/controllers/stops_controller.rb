class StopsController < ApplicationController
  # GET /stops
  # GET /stops.json


  def index
    @stops = Stop.all

    render json: @stops
  end

  # GET /stops/1
  # GET /stops/1.json
  def show
    predictions = CTA::BusTracker.predictions(:stpid => params(:stop_id), :rt => params(:route))
    next_times = predictions.map {|p| Time.parse(p['prdtm'])}

    render json: {next_time: next_times}
  end

  # POST /stops
  # POST /stops.json
  def create
    @stop = Stop.new(params[:stop])

    if @stop.save
      render json: @stop, status: :created, location: @stop
    else
      render json: @stop.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stops/1
  # PATCH/PUT /stops/1.json
  def update
    @stop = Stop.find(params[:id])

    if @stop.update_attributes(params[:stop])
      head :no_content
    else
      render json: @stop.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stops/1
  # DELETE /stops/1.json
  def destroy
    @stop = Stop.find(params[:id])
    @stop.destroy

    head :no_content
  end
end
