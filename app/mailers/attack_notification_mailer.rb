class AttackNotificationMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def attack_notification(attack_log)
    @attack_log = attack_log
    mail(to: ENV['EMAIL'], subject: 'Attack Detected')
  end
end
