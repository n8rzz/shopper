require 'rails_helper'

RSpec.describe 'MealSchedules', :type => :request do
  let(:user) { create(:user) }
  let!(:item) { create(:item, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  describe 'create request' do
    context 'invalid' do
      describe 'when no reference_id is passed' do
        before do
          post '/meal_schedules.json', :params => { :meal_schedule => {
            schedule_date: Time.now,
            purchased: false,
            meal_time: 'none'
          } }
        end

        it { expect(response.status).to eq(422) }
        it 'should return the correct response' do
          parsed_body = JSON.parse(response.body)

          expect(parsed_body['id']).to eq(nil)
          expect(parsed_body['item_id']).to eq(nil)
        end
      end

      describe 'when two reference_ids are passed' do
        let!(:assembly) { create(:assembly, ownable: user) }

        before do
          post '/meal_schedules.json', :params => { :meal_schedule => {
            schedule_date: Time.now,
            purchased: false,
            assembly_id: assembly.id,
            item_id: item.id
          } }
        end

        it { expect(response.status).to eq(422) }
        it 'should return the correct response' do
          parsed_body = JSON.parse(response.body)

          expect(parsed_body['id']).to eq(nil)
          expect(parsed_body['assembly_id']).to eq(nil)
          expect(parsed_body['item_id']).to eq(nil)
        end
      end
    end

    context 'valid' do
      before do
        post '/meal_schedules.json', :params => { :meal_schedule => {
          schedule_date: Time.now,
          purchased: false,
          item_id: item.id,
          meal_time: 'none'
        } }
      end

      it { expect(response.status).to eq(201) }

      it 'should return the correct response' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body['id']).to_not eq(nil)
        expect(parsed_body['item_id']).to eq(item.id)
      end
    end

    context 'should default #purchased to false' do
      before do
        post '/meal_schedules.json', :params => { :meal_schedule => {
          schedule_date: Time.now,
          item_id: item.id,
          meal_time: 'none'
        } }
      end

      it { expect(response.status).to eq(201) }

      it 'should return the correct response' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body['id']).to_not eq(nil)
        expect(parsed_body['item_id']).to eq(item.id)
        expect(parsed_body['purchased']).to eq(false)
      end
    end
  end

  describe 'delete request' do
    let(:meal_schedule) { create(:meal_schedule, item_id: item.id, ownable: user) }

    context 'should remove @meal_time' do
      before do
        delete "/meal_schedules/#{meal_schedule.id}.json"
      end

      it { expect(response.status).to eq(204) }
    end
  end
end
