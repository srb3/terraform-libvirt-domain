expected_hostname = input('expected_hostname')
expected_os_family = input('expected_os_family')
expected_os_name = input('expected_os_name')
expected_os_version = input('expected_os_version')
expected_disk_size = input('expected_disk_size')
expected_memory = input('expected_memory')
expected_vcpu = input('expected_vcpu')

describe bash('hostname') do
  its('stdout') { should match(/#{expected_hostname}/) }
end

describe os.family do
  it { should eq expected_os_family }
end

describe os.name do
  it { should eq expected_os_name }
end

describe os.release do
  it { should eq expected_os_version }
end

describe bash('df | grep root | awk \'{print $2}\' | tr -d "\n"') do
  its('stdout.to_i') { should be <= expected_disk_size }
end

describe bash('free | awk \'/Mem/ {print $2}\' | tr -d "\n"') do
  its('stdout.to_i') { should be >= expected_memory }
  its('stdout.to_i') { should be < 400_000_0 }
end

describe bash('cat /proc/cpuinfo | grep processor|wc -l') do
  its('stdout.to_i') { should eq expected_vcpu }
end
