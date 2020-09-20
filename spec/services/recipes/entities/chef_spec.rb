# frozen_string_literal: true

require 'rails_helper'

describe Recipes::Entities::Chef do
  it 'create valid entity' do
    entity = described_class.new(id: 'id', name: 'Chef #1')
    expect(entity.id).to eq 'id'
    expect(entity.name).to eq 'Chef #1'
  end

  describe '.wrap_entity' do
    it 'creates valid entity' do
      params = { 'sys' => { 'id' => 'id' }, 'fields' => { 'name' => 'Chef #1' } }
      entity = described_class.wrap_entity(params)
      expect(entity.id).to eq 'id'
      expect(entity.name).to eq 'Chef #1'
    end
  end
end
