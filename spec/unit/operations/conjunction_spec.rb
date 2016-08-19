require 'dry/logic/operations/conjunction'
require 'dry/logic/rule/predicate'

RSpec.describe Operations::Conjunction do
  subject(:rule) { Operations::Conjunction.new(left, right) }

  include_context 'predicates'

  let(:left) { Rule::Predicate.new(int?) }
  let(:right) { Rule::Predicate.new(gt?).curry(18) }

  describe '#call' do
    it 'calls left and right' do
      expect(rule.(18)).to be_failure
    end
  end

  describe '#and' do
    let(:other) { Rule::Predicate.new(lt?).curry(30) }

    it 'creates conjunction with the other' do
      expect(rule.and(other).(31)).to be_failure
    end
  end

  describe '#or' do
    let(:other) { Rule::Predicate.new(lt?).curry(14) }

    it 'creates disjunction with the other' do
      expect(rule.or(other).(13)).to be_success
    end
  end
end