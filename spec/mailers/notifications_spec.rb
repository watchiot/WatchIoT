require 'rails_helper'

RSpec.describe Notifier, type: :mailer do
  before :each do
    # add plan
    Plan.create!(name: 'Free', amount_per_month: 0)

    @user = User.create!(username: 'my_user_name', passwd: '12345678',
                         passwd_confirmation: '12345678')
    @email = Email.create!(email: 'user1@watchiot.com', user_id: @user.id,
                           checked: true, principal: true)
    @user_two = User.create!(username: 'my_user_name2', passwd: '12345678',
                             passwd_confirmation: '12345678')
    @space = Space.create!(name: 'my_space', user_id: @user_two.id)
  end
  describe 'Send signup email' do

    let(:mail) { Notifier
           .send_signup_email('email@watchiot.com', @user, '123456789') }

    it 'renders the headers' do
      expect(mail.subject).to eq('WatchIoT Account Activation')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded)
          .to match('Hi my_user_name, thanks for signing up!')
      expect(mail.body.encoded)
          .to match('/active/123456789<br/><br/>')
    end
  end

  describe 'Send signup verify email' do
    let(:mail) { Notifier
           .send_signup_verify_email('email@watchiot.com', @user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to WatchIoT!!')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded)
          .to match('Hi my_user_name!')
      expect(mail.body.encoded)
          .to match('Congratulations on your new WatchIoT account!'\
           ' Getting set up with WatchIoT is quick and easy.<br/><br/>')
    end
  end

  describe 'Send transfer space email' do
    let(:mail) { Notifier
           .send_transfer_space_email('email@watchiot.com', @user, @space) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Transferred space for you!!')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded)
          .to match('Hi my_user_name2,</h1><br/><br/> the space my_space'\
           ' was transferred for you!')
      expect(mail.body.encoded)
          .to match('by <strong>my_user_name\(user1@watchiot.com\)'\
          '</strong><br/><br/>')
    end
  end

  describe 'Send new team email' do
    let(:mail) { Notifier
           .send_new_team_email('email@watchiot.com', @user, @user_two) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your belong a new team!!')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('<h1>Hi my_user_name2</h1>')
      expect(mail.body.encoded)
          .to match('You have been invited by my_user_name\(user1@watchiot.com\)'\
          ' to join a new team on Watchiot.')
      expect(mail.body.encoded).to match('/my_user_name')
    end
  end

  describe 'Send create user email' do
    let(:mail) { Notifier
           .send_create_user_email('email@watchiot.com', '123456789') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your have been invited to WatchIoT!!')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded)
          .to match('You have been invited to join Watchiot.')
      expect(mail.body.encoded).to match('/invite/123456789')
    end
  end

  describe 'Send forget passwd email' do
    let(:mail) { Notifier
           .send_forget_passwd_email('email@watchiot.com', @user, '123456789') }

    it 'renders the headers' do
      expect(mail.subject).to eq('WatchIoT password reset!!')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi my_user_name,')
      expect(mail.body.encoded).to match('/reset/123456789')
    end
  end

  describe 'Send verify email' do
    let(:mail) { Notifier
           .send_verify_email('email@watchiot.com', @user, '123456789') }

    it 'renders the headers' do
      expect(mail.subject).to eq('WatchIoT verify email!!')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi my_user_name!')
      expect(mail.body.encoded).to match('/verify_email/123456789')
    end
  end

  describe 'Send reset passwd email' do
    let(:mail) { Notifier
           .send_reset_passwd_email('email@watchiot.com', @user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('WatchIoT password reset correctly!!')
      expect(mail.to).to eq(['email@watchiot.com'])
      expect(mail.from).to eq(['info@watchiot.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi my_user_name!')
      expect(mail.body.encoded)
          .to match('<p>The password was reset correctly.</p></br>')
    end
  end
end
