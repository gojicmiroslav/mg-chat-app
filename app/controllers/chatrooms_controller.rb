class ChatroomsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chatroom, only: [:show, :edit, :update, :destroy]
    before_action :owners_only, only: [:edit, :update, :destroy]

    # GET /chatrooms
    # GET /chatrooms.json
    def index
        @chatrooms = Chatroom.get_chatrooms_for(current_user)
    end

    # GET /chatrooms/1
    # GET /chatrooms/1.json
    def show
        @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id);
    end

    # GET /chatrooms/new
    def new
        @chatroom = Chatroom.new
    end

    # GET /chatrooms/1/edit
    def edit
    end

    # POST /chatrooms
    # POST /chatrooms.json
    def create
        @chatroom = Chatroom.new(chatroom_params)
        @chatroom.user = current_user
        @chatroom.users << current_user

        respond_to do |format|
            if @chatroom.save
                format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
                format.json { render :show, status: :created, location: @chatroom }
            else
                format.html { render :new }
                format.json { render json: @chatroom.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /chatrooms/1
    # PATCH/PUT /chatrooms/1.json
    def update
        respond_to do |format|
            if @chatroom.update(chatroom_params)
                format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
                format.json { render :show, status: :ok, location: @chatroom }
            else
                format.html { render :edit }
                format.json { render json: @chatroom.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /chatrooms/1
    # DELETE /chatrooms/1.json
    def destroy
        @chatroom.destroy
        respond_to do |format|
            format.html { redirect_to chatrooms_url, notice: 'Chatroom was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private

    def set_chatroom
        @chatroom = Chatroom.find(params[:id])
    end 

    def chatroom_params
        params.require(:chatroom).permit(:name)
    end

    def owners_only
        @chatroom = Chatroom.find(params[:id])
        if current_user != @chatroom.user
            redirect_to(chatrooms_path)
        end
    end
end
