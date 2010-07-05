class GuestbooksController < ApplicationController
  trans_sid :mobile

  # GET /guestbooks
  # GET /guestbooks.xml
  def index
    session[:t] = Time.now

    @guestbooks = Guestbook.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guestbooks }
    end
  end

  # GET /guestbooks/1
  # GET /guestbooks/1.xml
  def show
    @guestbook = Guestbook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @guestbook }
    end
  end

  # GET /guestbooks/new
  # GET /guestbooks/new.xml
  def new
    @guestbook = Guestbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guestbook }
    end
  end

  # GET /guestbooks/1/edit
  def edit
    @guestbook = Guestbook.find(params[:id])
  end

  # POST /guestbooks
  # POST /guestbooks.xml
  def create
require 'pp'
str = ""
params[:guestbook][:comment].each_byte{|s| str << "%x " % s }
pp str
    @guestbook = Guestbook.new(params[:guestbook])

    respond_to do |format|
      if @guestbook.save
        format.html { redirect_to(@guestbook, :notice => 'Guestbook was successfully created.') }
        format.xml  { render :xml => @guestbook, :status => :created, :location => @guestbook }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guestbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /guestbooks/1
  # PUT /guestbooks/1.xml
  def update
    @guestbook = Guestbook.find(params[:id])

    respond_to do |format|
      if @guestbook.update_attributes(params[:guestbook])
        format.html { redirect_to(@guestbook, :notice => 'Guestbook was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guestbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guestbooks/1
  # DELETE /guestbooks/1.xml
  def destroy
    @guestbook = Guestbook.find(params[:id])
    @guestbook.destroy

    respond_to do |format|
      format.html { redirect_to(guestbooks_url) }
      format.xml  { head :ok }
    end
  end
end
module ActionDispatch::Http::Parameters
  def parameters
requrie 'pp'
pp "--------------"
pp request_parameters
pp query_parameters
pp path_parameters
pp "--------------"
    @env["action_dispatch.request.parameters"] ||= request_parameters.merge(query_parameters).update(path_parameters).with_indifferent_access
  end
end
