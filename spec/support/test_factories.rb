module TestFactories
  def self.authenticated_admin(options={})
    user_options = { 
      name: "Matt", 
      email: "email#{rand}@example.com", 
      password: "password", 
      role: "admin" 
    }.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end

  def self.authenticated_standard(options={})
    user_options = { 
      name: "Jessica", 
      email: "email#{rand}@example.com", 
      password: "password", 
      role: "standard" 
    }.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end

  def self.authenticated_premium(options={})
    user_options = { 
      name: "Bob", 
      email: "email#{rand}@example.com", 
      password: "password", 
      role: "premium" 
    }.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end    

  def self.associated_wiki(options={})
    wiki_options = {
      title:  "Wiki#{rand}",
      body: 'Wiki text should contain lots of important info.',
      user: TestFactories.authenticated_admin
    }.merge(options)
    Wiki.create(wiki_options)
  end

end