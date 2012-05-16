require 'spec_helper'

module PYAPNS
  describe Client do
    let(:klass) { Client.clone }
    subject { klass.instance }

    describe "initialization"  do
      it { should be_a(Singleton) }
      it { should_not be_configured }
    end

    describe "::configure" do
      let(:options) { double }

      it "delegates to #configure" do
        subject.should_receive(:configure).with(options)
        klass.configure(options)
      end
    end

    describe "#configure" do
      let(:xmlrpc_client) { double }

      context "defaults" do
        let(:options) { Hash.new }

        before do
          XMLRPC::Client.should_receive(:new3).with({:host => 'localhost', :path => '/', :port => 7077, :timeout => 15}).and_return(xmlrpc_client)
          subject.configure(options)
        end

        it "for host is localhost" do
          subject.instance_variable_get('@host').should == 'localhost'
        end

        it "for port is 7077" do
          subject.instance_variable_get('@port').should == 7077
        end

        it "for path is /" do
          subject.instance_variable_get('@path').should == '/'
        end

        it "for timeout is 15" do
          subject.instance_variable_get('@timeout').should == 15
        end

        it "for max_attempts is 4" do
          subject.instance_variable_get('@max_attempts').should == 4
        end

        it "sets XML-RPC client with provided host, path, port and timeout" do
          subject.instance_variable_get('@client').should == xmlrpc_client
        end

        it { should be_configured }
      end

      context "custom configuration" do
        let(:options) do
          {
            'host' => 'http://some.host.com',
            'port' => 9999,
            'path' => '/some/path',
            'timeout' => 30,
            'max_attempts' => 5,
            'initial' => [
              {
                :app_id => 'myapp',
                :cert => '/path/to/cert',
                :env => 'sandbox',
                :timeout => 30,
              }
            ]
          }
        end

        before do
          XMLRPC::Client.should_receive(:new3).with({
            :host => options['host'],
            :path => options['path'],
            :port => options['port'],
            :timeout => options['timeout']
          }).and_return(xmlrpc_client)

          subject.should_receive(:provision).with({
            :app_id => 'myapp',
            :cert => '/path/to/cert',
            :env => 'sandbox',
            :timeout => 30
          })

          subject.configure(options)
        end

        it "host is set to value of 'host' key in options hash" do
          subject.instance_variable_get('@host').should == 'http://some.host.com'
        end

        it "port is set to value of 'port' key in options hash" do
          subject.instance_variable_get('@port').should == 9999
        end

        it "path is set to value of 'path' key in options hash" do
          subject.instance_variable_get('@path').should == '/some/path'
        end

        it "timeout is set to value of 'timeout' key in options hash" do
          subject.instance_variable_get('@timeout').should == 30
        end

        it "maximum number of attempts is set to value of 'max_attempts' key in options hash" do
          subject.instance_variable_get('@max_attempts').should == 5
        end

        it "sets XML-RPC client with provided host, path, port and timeout" do
          subject.instance_variable_get('@client').should == xmlrpc_client
        end

        it { should be_configured }
      end
    end

    describe "#notify" do
      let(:xmlrpc_client) { double }
      let(:token) { 'some-token' }
      let(:tokens) { [token] }
      let(:notification) { {:aps=> {:alert => 'Kia Ora!'}} }
      let(:notifications) { [notification] }
      let(:encoded_notification) { double }
      let(:encoded_notifications) { [encoded_notification] }

      before do
        PYAPNS::Notification.should_receive(:encode).with(notification).and_return(encoded_notification)
        XMLRPC::Client.should_receive(:new3).with({:host => 'localhost', :path => '/', :port => 7077, :timeout => 15}).and_return(xmlrpc_client)

        subject.configure
      end

      it "accepts app, array_of_tokens, array_of_notifications" do
        xmlrpc_client.should_receive(:call_async).with('notify', 'myapp', tokens, encoded_notifications)
        subject.notify('myapp', tokens, notifications)
      end

      it "accepts app, token, notification" do
        xmlrpc_client.should_receive(:call_async).with('notify', 'myapp', tokens, encoded_notifications)
        subject.notify('myapp', token, notification)
      end
    end
  end
end
