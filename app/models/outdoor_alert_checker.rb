class OutdoorAlertChecker
  attr_reader :params, :user

  def initialize(params, user)
    @params = params
    @user = user
    @errors = []
  end


end
