class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

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

      @tweets = @tweets.page(params[:page]).per(15)
  
    end

    def new
        @tweet = Tweet.new
      end

      def create
        tweet = Tweet.new(tweet_params)

        tweet.user_id = current_user.id 

        if tweet.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end

      def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new
      end

      def edit
        @tweet = Tweet.find(params[:id])
      end

      def update
        tweet = Tweet.find(params[:id])
        if tweet.update(tweet_params)
          redirect_to :action => "show", :id => tweet.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to action: :index
      end
    
      private
      def tweet_params
        params.require(:tweet).permit(:image, :about, :spot, :title, :spot2,  :spot3, tag_ids: [])
      end

      
class MapsController < ApplicationController
  def index
  end
end

end


def index
  @tweets = Tweet.all
  if params[:search] == nil
    @tweets= Tweet.all
  elsif params[:search] == ''
    @tweets= Tweet.all
  elsif params[:search] == nil
    @tweet = params[:tag_id].present? ? Tag.find(params[:tag_id]).tweets : Tweet.all
    @tweet = params[:tag_id].present? ? Tag2.find(params[:tag_id]).tweets : Tweet.all
    @tweet = params[:tag_id].present? ? Tag3.find(params[:tag_id]).tweets : Tweet.all
    @tweet = params[:tag_id].present? ? Tag4.find(params[:tag_id]).tweets : Tweet.all
  elsif params[:search] == ''
    @tweet = params[:tag_id].present? ? Tag.find(params[:tag_id]).tweets : Tweet.all
    @tweet = params[:tag_id].present? ? Tag2.find(params[:tag_id]).tweets : Tweet.all
    @tweet = params[:tag_id].present? ? Tag3.find(params[:tag_id]).tweets : Tweet.all
    @tweet = params[:tag_id].present? ? Tag4.find(params[:tag_id]).tweets : Tweet.all
  elsif params[:search].present?
    @tweets = Tweet.where("body LIKE ? ",'%' + params[:search] + '%')
  else
    @tweets = Tweet.where("name LIKE ? ",'%' + params[:search] + '%')
  end
end

def index
  @tweets = Tweet.all
  search = params[:search]
  @tweets = @tweets.joins(:user).where("name LIKE ?", "%#{search}%") if search.present?
  if params[:tag_ids]
    @tweets = []
    params[:tag_ids].each do |key, value|
      @tweets += Tag.find_by(name: key).tweets if value == "1"
    end
    @tweets.uniq!
  end
end