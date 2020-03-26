class Secret
  def initialize
    @secrets = {}
  end

  def add(user, password, secret)
    if @secrets[user]
      false
    else
      @secrets[user] = [password, secret]
    end
  end

  def check(user, password, *job)
    if exist?(user) && @secrets[user][0] == password
      if job[0] == 'show'
        show(user)
      elsif job[0] == 'change'
        change(user, job[1])
      end
    else
      false
    end
  end

  def exist?(user)
    @secrets[user] ? true : false
  end

  private

  def change(user, new_secret)
    @secrets[user].pop
    @secrets[user].push(new_secret)
  end

  def show(user)
    @secrets[user][1]
  end
end
