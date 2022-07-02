class CandidatesController < ApplicationController
    # @是一個實體變數 在controller做好的實體變數 在view就可以拿得到:)
    # 大寫的Candidate就是model ;) 請model去跟資料庫抓資料
    def index
        @candidates = Candidate.all #在主頁面就會顯示所有從new寫入的candidate資料
    end
    def new
        @candidate = Candidate.new
    end
    def create
        @candidate = Candidate.new(clean_params)
        #debugger 在這邊放一個debugger測試的時候 在terminal就可以看到byebug, 在那邊打params[:candidate]就可以看到剛剛在new表單裡送出的資料 打continue就可以離開debugger
        if @candidate.save
            flash[:notice] = "Candidate created!"
            redirect_to '/candidates'
        else 
            flash[:notice] = "Please fill in name!"
            render :new #在candidate.rb裡validate名字一定要填, 所以沒有填寫的話會到這個else，render :new會回到原本頁面 但是保有已經填好的欄位
            
        end
            
    end

    def show
        @candidate = Candidate.find_by(id: params[:id])
    end

    private 
    # 只要叫的是這個method, 資料就被確認過了 不會被Attribute error擋下來
    def clean_params
        params.require(:candidate).permit(:name, :party, :age, :politics)
    end
end
