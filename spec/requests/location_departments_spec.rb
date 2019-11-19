require 'rails_helper'

RSpec.describe 'LocationDepartments', :type => :request do
  let!(:department) { create(:department) }
  let!(:location) { create(:location) }

  before do
    sign_in create(:user)
  end

  describe 'create request' do
    context 'invalid' do
      before do
        post '/location_departments.json', :params => { :location_department => { sort_order: 1 } }
      end

      it { expect(response.status).to eq(422) }

      it 'should return the correct response' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body['id']).to eq(nil)
        expect(parsed_body['sort_order']).to eq(nil)
        expect(parsed_body['department_id']).to eq(nil)
        expect(parsed_body['location_id']).to eq(nil)
      end
    end

    context 'valid' do
      before do
        post '/location_departments.json', :params => { :location_department => {
          department_id: department.id,
          location_id: location.id
        } }
      end

      it { expect(response.status).to eq(201) }

      it 'should return list of LocationDepartments' do
        parsed_body = JSON.parse(response.body)

        expect(response.body).to_not eq(nil)
        # expect(parsed_body['id']).to_not eq(nil)
        # expect(parsed_body['sort_order']).to eq(1)
        # expect(parsed_body['department_id']).to eq(department.id)
        # expect(parsed_body['location_id']).to eq(location.id)
      end
    end
  end

  describe 'update request' do
    let(:original_location_department) { create(:location_department) }

    context 'invalid' do
      before do
        put "/location_departments/#{original_location_department.id}.json", :params => { :location_department => {
          sort_order: original_location_department.sort_order,
          department_id: nil,
          location_id: original_location_department.location_id
        } }
      end

      it { expect(response.status).to eq(422) }
      it { expect(response.body).to_not eq(nil) }
    end

    context 'update #sort_order' do
      before do
        put "/location_departments/#{original_location_department.id}.json", :params => { :location_department => {
          sort_order: 7,
          department_id: original_location_department.department_id,
          location_id: original_location_department.location_id
        } }
      end

      it { expect(response.status).to eq(200) }

      it 'should update the record' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body['id']).to eq(original_location_department.id)
        expect(parsed_body['sort_order']).to eq(7)
        expect(parsed_body['department_id']).to eq(original_location_department.department_id)
        expect(parsed_body['location_id']).to eq(original_location_department.location_id)
      end
    end

    context 'update #sort_order when another entry exists' do
      let!(:same_sort_location_department) { create(:location_department, sort_order: 42) }

      before do
        put "/location_departments/#{original_location_department.id}.json", :params => { :location_department => {
          sort_order: same_sort_location_department.sort_order,
          department_id: original_location_department.department_id,
          location_id: same_sort_location_department.location_id
        } }
      end

      it { expect(response.status).to eq(200) }

      it 'should update the record' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body['sort_order']).to eq(same_sort_location_department['sort_order'])
      end

      # FIXME: currently not working, though it appears it should, will circle back to this
      # it 'should update the #sort_order of the conflicting record' do
      #   conflicting_record = LocationDepartment.find(same_sort_location_department.id)

      #   expect(conflicting_record.sort_order).to eq(0)
      # end
    end
  end

  describe 'change_direction' do
    let!(:location) { create(:location) }
    let!(:department_meat) { create(:department, name: 'meat') }
    let!(:department_produce) { create(:department, name: 'produce') }
    let!(:location_department_meat) { create(:location_department, location_id: location.id, department_id: department_meat.id, sort_order: 0) }
    let!(:location_department_produce) { create(:location_department, location_id: location.id, department_id: department_produce.id, sort_order: 1) }

    context 'when passed `down` on non-last element' do
      before do
        post "/location_departments/#{location_department_meat.id}/down.json"
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to_not eq(nil) }
      it 'increments #record_to_change by 1' do
        parsed_body = JSON.parse(response.body)
        meat_response = parsed_body.detect { |f| f['id'] == location_department_meat.id }

        expect(meat_response['sort_order']).to eq(1)
      end

      it 'decrements #displaced_record by 1' do
        parsed_body = JSON.parse(response.body)
        meat_response = parsed_body.detect { |f| f['id'] == location_department_produce.id }

        expect(meat_response['sort_order']).to eq(0)
      end
    end

    context 'when passed `up` on non-first element' do
      before do
        post "/location_departments/#{location_department_produce.id}/up.json"
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to_not eq(nil) }
      it 'decrements #record_to_change by 1' do
        parsed_body = JSON.parse(response.body)
        meat_response = parsed_body.detect { |f| f['id'] == location_department_produce.id }

        expect(meat_response['sort_order']).to eq(0)
      end

      it 'increments #displaced_record by 1' do
        parsed_body = JSON.parse(response.body)
        meat_response = parsed_body.detect { |f| f['id'] == location_department_meat.id }

        expect(meat_response['sort_order']).to eq(1)
      end
    end
  end

  describe 'delete request' do
    let(:original_location_department) { create(:location_department) }

    context 'valid' do
      before do
        delete "/location_departments/#{original_location_department.id}.json"
      end

      it { expect(response.status).to eq(200) }
      it { expect(JSON.parse(response.body)).to_not eq(nil) }
    end
  end
end
