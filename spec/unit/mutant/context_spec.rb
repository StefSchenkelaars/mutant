RSpec.describe Mutant::Context::Scope do
  describe '.wrap' do
    subject { described_class.wrap(scope, node) }

    let(:node)  { s(:str, 'test') }

    context 'with Module as scope' do
      let(:scope) { Mutant          }

      let(:expected) do
        s(:module,
          s(:const, nil, :Mutant),
          s(:str, 'test')
        )
      end

      it { should eql(expected) }
    end

    context 'with Class as scope' do
      let(:scope) { Mutant::Context }

      let(:expected) do
        s(:class,
          s(:const, nil, :Context),
          nil,
          s(:str, 'test')
        )
      end

      it { should eql(expected) }
    end

    context 'with Class as scope' do
      let(:scope) { Mutant::Context }

      let(:expected) do
        s(:class,
          s(:const, nil, :Context),
          nil,
          s(:str, 'test')
        )
      end

      it { should eql(expected) }
    end

    context 'with anything else as scope' do
      let(:scope) { double(name: 'Foo') }

      it 'raises exception' do
        expect { subject }.to raise_error(RuntimeError, "Cannot wrap scope: #{scope.inspect}")
      end
    end
  end
end
