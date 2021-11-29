class Api::V1::UrlsController < ApplicationController

    def index
      @urls = Url.last(10)
      render json: {status: 'SUCCESS', message: 'Loaded Urls', data: @urls}, status: :ok
    end


    def create
      short_name = ('A'..'Z').to_a.shuffle[0,5].join.upcase # This will generate 

      if check_if_single_word(short_name)
        @url = Url.new(url_params)
        @url.short_url = short_name
        if @url.save
          render json: {status: 'SUCCESS', message: 'URL Created', data: @url}, status: :created
        else
          render json: {status: 'Error', message: 'URL Not Created'}, status: :ok
        end
      else
          # Error is here
          render json: {status: 'Error', message: 'URL Not Created'}, status: :ok
      end
    end

    def show
      @url = Url.find_by_short_url(params[:url])
    end


    private

    def url_params
      params.require(:url).permit(:original_url)
    end
end
