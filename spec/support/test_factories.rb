module TestFactories
  def self.authenticated_user(options={})
    user_options = { name: "Matt", email: "email#{rand}@example.com", password: "password" }.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end

  def self.associated_wiki(options={})
    wiki_options = {
      title:  "Wiki#{rand}",
      body: 'Wiki text should contain lots of important info.',
      user: TestFactories.authenticated_user
    }.merge(options)
    Wiki.create(wiki_options)
  end

end