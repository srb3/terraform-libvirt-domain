expected_os_family = input('expected_os_family')
expected_os_name = input('expected_os_name')
expected_os_version = input('expected_os_version')
expected_disk_size = input('expected_disk_size').to_i
expected_memory = input('expected_memory').to_i
expected_vcpu = input('expected_vcpu').to_i
expected_packages = input('expected_packages')
expected_dirs = input('expected_dirs')
expected_services = input('expected_services')
expected_container_image = input('expected_container_image')
expected_container_name = input('expected_container_name')
expected_container_tag = input('expected_container_tag')
expected_container_repo = input('expected_container_repo')

# wait for cloud init to finish

count = 0

loop do
  raise 'Cloud init did not finish in time' if count == 300

  puts "exit status: #{command('ls /tmp/finished').exit_status}"
  puts "exit status class: #{command('ls /tmp/finished').exit_status.class}"
  break if command('ls /tmp/finished').exit_status.zero?

  puts 'Waiting for cloud init to finish ...'
  count += 10
  sleep 10
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
  its('stdout.to_i') { should be < 450_000_0 }
end

describe bash('cat /proc/cpuinfo | grep processor|wc -l') do
  its('stdout.to_i') { should eq expected_vcpu }
end

expected_dirs.each do |d|
  describe directory(d) do
    it { should exist }
  end
end

expected_services.each do |s|
  describe systemd_service(s) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

expected_packages.each do |p|
  describe packages(p) do
    its('statuses') { should cmp 'installed' }
  end
end

describe docker_container(name: expected_container_name) do
  it { should exist }
  it { should be_running }
  its('id') { should_not eq '' }
  its('image') { should eq expected_container_image }
  its('repo') { should eq expected_container_repo }
  its('tag') { should eq expected_container_tag }
end
