expected_hostname = input('expected_hostname')
expected_os_name = input('expected_os_name')
expected_os_version = input('expected_os_version')
expected_disk_size = input('expected_disk_size')
expected_memory = input('expected_memory')
expected_vcpu = input('expected_vcpu')

describe bash('hostname') do
  its('stdout') { should match(/#{expected_hostname}/) }
end

describe bash('awk -F\'"\' \'/^NAME=/ {print $2}\' /etc/os-release |tr \'[:upper:]\' \'[:lower:]\'') do
  its('stdout') { should match(/#{expected_os_name}/) }
end

describe bash('awk -F\'"\' \'/^VERSION_ID=/ {print $2}\' /etc/os-release') do
  its('stdout') { should match(/#{expected_os_version}/) }
end

describe bash('df | grep root | awk \'{print $2}\' | tr -d "\n"') do
  its('stdout.to_i') { should be <= expected_disk_size }
end

describe bash('free | awk \'/Mem/ {print $2}\' | tr -d "\n"') do
  its('stdout.to_i') { should be >= expected_memory }
  its('stdout.to_i') { should be < 400_000_0 }
end

describe bash('cat /proc/cpuinfo | grep processor|wc -l') do
  its('stdout') { should match(/#{expected_vcpu}/) }
end
