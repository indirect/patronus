class Reviewership < ActiveRecord::Base
  belongs_to :user
  belongs_to :repo

  accepts_nested_attributes_for :repo

  def ensure_webhook_installed!
    hook_url = url_for controller: "github_web_hook", action: "create"
    unless user.github.hooks(repo.name).find { |hook| hook.url == hook_url }
      user.github.create_hook(repo.name, "web", { url: hook_url, content_type: :json}, { events: "*", secret: ENV['GITHUB_WEBHOOK_SECRET'.freeze] })
    end
  end
end
