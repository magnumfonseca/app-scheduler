require 'rails_helper'

feature 'Event new' do
  scenario 'with success', :js => true do
    user = create(:user)
    sign_in(user)

    first('.available').click
    wait_for_ajax

    expect(page).to have_css('b', text: user.name)
  end
  scenario 'event already take in other session', :js => true do
    user = create(:user)
    sign_in(user)
    week = Date.today.cweek
    event = Event.new(week: week, day: "seg", hour: 06)
    other_user = create(:user, events: [ event ])

    first('.available').click
    wait_for_ajax

    expect(page).to_not have_css('b', text: user.name)
    expect(page).to have_css('.alert', text: "Aviso: Este horário foi reservado por um usuário em outra sessão, atualize a página para sincronizar as informações.")
  end
end
