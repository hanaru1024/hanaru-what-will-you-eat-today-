class SituationsController < ApplicationController
    def index
        if params[:search] == nil
          @tweets= Tweet.all
        elsif params[:search] == ''
          @tweets = Tweet.all
        else
          #部分検索
          @tweets = Tweet.where("spot LIKE ? ",'%' + params[:search] + '%')
        end
    
        if params[:tag_ids]
          @tweets = []
          params[:tag_ids].each do |key, value|      
            @tweets += Tag.find_by(name: key).tweets if value == "1"
          end
          @tweets.uniq!
        end
    
        if params[:tag]
          Tag.create(name: params[:tag])
        end
    
        @tweets = @tweets.page(params[:page]).per(30)
    
    end
end


