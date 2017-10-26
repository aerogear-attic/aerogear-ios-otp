#
# JBoss, Home of Professional Open Source
# Copyright Red Hat, Inc., and individual contributors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
Pod::Spec.new do |s|
  s.name         = "AeroGearOTP"
  s.version      = "1.0.1"
  s.summary      = "Provides an Objective-C One Time Password API."
  s.homepage     = "https://github.com/aerogear/aerogear-ios-otp"
  s.license      = 'Apache License, Version 2.0'
  s.author       = "Red Hat, Inc."
  s.source       = { :git => 'https://github.com/aerogear/aerogear-ios-otp.git', :tag => '1.0.1' }
  s.platform     = :ios, 9.0
  s.source_files = 'AeroGearOTP/Classes/*.{h,m}'
  s.public_header_files = 'AeroGearOTP/Classes/AeroGearOTP.h', 'AeroGearOTP/Classes/AGOtp.h', 'AeroGearOTP/Classes/AGTotp.h', 'AeroGearOTP/Classes/AGClock.h', 'AeroGearOTP/Classes/AGBase32.h', 'AeroGearOTP/Classes/AGStringEncoding.h'
  s.requires_arc = true
end
