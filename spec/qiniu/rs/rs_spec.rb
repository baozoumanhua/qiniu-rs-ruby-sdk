# -*- encoding: utf-8 -*-

require 'digest/sha1'
require 'spec_helper'
require 'qiniu/rs/auth'
require 'qiniu/rs/io'
require 'qiniu/rs/rs'

module Qiniu
  module RS
    describe RS do

      before :all do

        @bucket = "test_bucket_1234"
        @key = Digest::SHA1.hexdigest (Time.now.to_i+rand(100)).to_s
        @domain = 'iovip.qbox.me/test'

        code, data = Qiniu::RS::RS.mkbucket(@bucket)
        code.should == 200
        puts data.inspect
      end

      context "IO.upload_file" do
        it "should works" do
          code, data = Qiniu::RS::IO.put_auth()
          code.should == 200
          data["url"].should_not be_empty
          data["expiresIn"].should_not be_zero
          puts data.inspect
          @put_url = data["url"]

          code2, data2 = Qiniu::RS::IO.upload_file(@put_url, __FILE__, @bucket, @key)
          code2.should == 200
          puts data2.inspect
        end
      end

      context ".buckets" do
        it "should works" do
          code, data = Qiniu::RS::RS.buckets
          code.should == 200
          puts data.inspect
        end
      end

      context ".stat" do
        it "should works" do
          code, data = Qiniu::RS::RS.stat(@bucket, @key)
          code.should == 200
          puts data.inspect
        end
      end

      context ".get" do
        it "should works" do
          code, data = Qiniu::RS::RS.get(@bucket, @key, "rs_spec.rb", 1)
          code.should == 200
          puts data.inspect
        end
      end

      context ".batch" do
        it "should works" do
          code, data = Qiniu::RS::RS.batch("stat", @bucket, [@key])
          code.should == 200
          puts data.inspect
        end
      end

      context ".batch_stat" do
        it "should works" do
          code, data = Qiniu::RS::RS.batch_stat(@bucket, [@key])
          code.should == 200
          puts data.inspect
        end
      end

      context ".batch_get" do
        it "should works" do
          code, data = Qiniu::RS::RS.batch_get(@bucket, [@key])
          code.should == 200
          puts data.inspect
        end
      end

      context ".publish" do
        it "should works" do
          code, data = Qiniu::RS::RS.publish(@domain, @bucket)
          code.should == 200
          puts data.inspect
        end
      end

      context ".unpublish" do
        it "should works" do
          code, data = Qiniu::RS::RS.unpublish(@domain)
          code.should == 200
          puts data.inspect
        end
      end

      context ".delete" do
        it "should works" do
          code, data = Qiniu::RS::RS.delete(@bucket, @key)
          code.should == 200
          puts data.inspect
        end
      end

      context ".drop" do
        it "should works" do
          code, data = Qiniu::RS::RS.drop(@bucket)
          code.should == 200
          puts data.inspect
        end
      end

    end
  end
end
