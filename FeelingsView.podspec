Pod::Spec.new do |s|
s.name             = 'FeelingsView'
s.module_name      = 'FeelingsView'
s.version          = '1.1'
s.summary          = 'Another rating view to share your feelings. 🎭'
s.description      = 'Want to create a feedback view for your business. Feelings would be the best choise to add in your next iOS app.'
s.homepage         = 'https://github.com/hemangshah/Feelings'
s.license          = 'MIT'
s.author           = { 'hemangshah' => 'hemangshah.in@gmail.com' }
s.source           = { :git => 'https://github.com/hemangshah/Feelings.git', :tag => s.version.to_s }
s.platform     = :ios, '9.0'
s.requires_arc = true
s.source_files = 'Feelings/Feelings/Source/*.swift'
end
