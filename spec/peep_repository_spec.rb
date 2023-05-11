#file: spec/peep_repository_spec.rb

#require 'peep'
require '/Users/chayadasansiriwong/Desktop/csanann/Projects/chitter-challenge/app/models/peep_repository.rb'

def reset_peeps_table
  seed_sql = File.read('data/tables_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter'})
  connection.exec(seed_sql)
end

RSpec.describe PeepRepository do
      
  before(:each)do
    reset_peeps_table
  end

  context '#all' do
    it 'returns a list of users' do
      repo = PeepRepository.new
      peeps = repo.all

      expect(peeps.length).to eq(2)
      expect(peeps[0].id).to eq(1).to_i
      expect(peeps[0].message).to eq('My name is Ken YoohaaaYoo.')
    end
  end

  context '#create' do
    it 'creates a new peep' do
      repo = PeepRepository.new

      created_peep = Peep.new
      create_peep.message = 'What a lovely day!'
      create_peep.user_id = '1'
      create_peep.timestamp = '2023-05-11 09:09:08'
      repo.create(created_peep)

      peeps = repo.all
      last_peep = peeps.last

      expect(peeps.length).to eq(5)
      expect(peeps.last.message).to eq('What a lovely day!')
      expect(peeps.last.user_id).to eq(1)
    end
  end

  context '#find_by_id' do
    it 'finds a single peep' do
      repo = PeepRepository.new
      peep = repo.find_by_id(2)

      expect(peep.message).to eq('What a lovely peep.')
      expect(peep.timestamp).to eq('2023-05-11 09:08:08')
      expect(peep.user.name).to eq(2)
      expect(peep.user.username).to eq('jan')
    end
  end
end