require 'spec_helper'

describe V8::C::Template do
  before do
    @cxt = V8::C::Context::New()
    @cxt.Enter()
  end
  after do
    @cxt.Exit()
  end

  describe V8::C::FunctionTemplate do
    it "can be created with no arguments" do
      V8::C::HandleScope() do
        t = V8::C::FunctionTemplate::New()
        t.GetFunction().Call(@cxt.Global(),0, []).StrictEquals(@cxt.Global()).should be_true
      end
    end

    it "can be created with a callback" do
      V8::C::HandleScope() do
        receiver = V8::C::Object::New()
        f = nil
        callback = lambda do |arguments|
          arguments.Length().should be(2)
          arguments[0].Utf8Value().should eql 'one'
          arguments[1].Utf8Value().should eql 'two'
          arguments.Callee().StrictEquals(f).should be_true
          arguments.This().StrictEquals(receiver).should be_true
          arguments.Holder().StrictEquals(receiver).should be_true
          arguments.IsConstructCall().should be_false
          arguments.Data().Value().should be(42)
          nil
        end
        t = V8::C::FunctionTemplate::New(callback, V8::C::External::New(42))
        f = t.GetFunction()
        f.Call(receiver, 2, [V8::C::String::New('one'), V8::C::String::New('two')])
      end
    end
  end
end