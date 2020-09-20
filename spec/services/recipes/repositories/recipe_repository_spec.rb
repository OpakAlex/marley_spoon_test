# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Recipes::Repositories::RecipeRepository do
  let(:json) { File.read(Rails.root.join('spec/fixtures/recipes.json')) }

  before do
    allow_any_instance_of(described_class).to receive(:api_response).and_return(json)
  end

  subject { described_class.new }

  describe '#all' do
    it 'find returns all records' do
      records = subject.all
      expect(records.size).to eq 4
      record = records.find { |rec| rec.id == '2E8bc3VcJmA8OgmQsageas' }
      expect(record.title).to eq 'Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing'
      expect(record.description).not_to be_nil
      expect(record.chef.name).to eq 'Mark Zucchiniberg '
      expect(record.tags.size).to eq 0
      expect(record.asset.url).to eq 'https://images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy0K/2a4cde3c1c7e374166dcce1e900cb3c1/SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg'
    end
  end

  describe '#find_by_id' do
    it 'returns record by id' do
      id = '4dT8tcb6ukGSIg2YyuGEOm'
      record = subject.find_by_id(id)
      expect(record.title). to eq 'White Cheddar Grilled Cheese with Cherry Preserves & Basil'
      expect(record.chef).to be_nil
      expect(record.asset.url).to eq 'https://images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg'
      expect(record.tags.size).to eq 1
      tag = record.tags.first
      expect(tag.name).to eq 'vegan'
    end
  end
end
# rubocop:enable Metrics/BlockLength
