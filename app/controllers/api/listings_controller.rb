class Api::ListingsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    protect_from_forgery with: :null_session
    
    def authenticate
        authenticate_or_request_with_http_basic do |user, password|
            user == "phil" && password == "cats"
        end
    end
    
    def index
        render json: Listing.all
    end
    
    def show
        list = Listing.find(params[:id])
        render json: list
    end
    
    def create
        list = Listing.new(listing_params)
        if list.save
            render json: {
                status: 200,
                message: "Successfully created",
                listing: list
            }.to_json
        else
            render json: {
                status: 500,
                errors: list.errors
            }.to_json
        end
    end
    
    def destroy
        list = Listing.find(params[:id])
        list.destroy
        render json: {
            status: 200,
            message: "successfully deleted list item"
        }.to_json
    end
    
    private
    def listing_params
        params.require(:listing).permit(:name, :description, :price)
    end
end