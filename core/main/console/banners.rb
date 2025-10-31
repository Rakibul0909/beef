# /home/kali/beef-master/core/main/console/banners.rb
#
# Copyright (c) 2006-2025 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - https://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
require 'socket'

module BeEF
  module Core
    module Console
      module Banners
        class << self
          attr_accessor :interfaces

          #
          # Prints BeEF's ascii art
          #
          def print_ascii_art
            path = 'core/main/console/beef.ascii'
            return unless File.exist?(path)
            File.readlines(path, chomp: true).each { |line| puts line }
          end

          #
          # Prints BeEF's welcome message
          #
          def print_welcome_msg
            config = BeEF::Core::Configuration.instance
            version = config.get('beef.version')
            print_info "Browser Exploitation Framework (BeEF) #{version}"
            data = <<~MSG
              Twit: @beefproject
              Site: https://beefproject.com
              Wiki: https://github.com/beefproject/beef/wiki
            MSG
            print_more data
            print_info 'Project Creator: ' + 'Wade Alcorn'.red + ' (@WadeAlcorn)'
          end

          #
          # Prints the number of network interfaces beef is operating on.
          # Robust: avoids Errno::EACCES by preferring fallbacks when not root.
          #
          def print_network_interfaces_count
            configuration = BeEF::Core::Configuration.instance
            beef_host = configuration.local_host
            interfaces = []

            begin
              if beef_host == '0.0.0.0'
                # Try only if root
                if Process.uid == 0
                  begin
                    interfaces = Socket.ip_address_list.select { |x| x.ipv4? && !x.ip_address.start_with?('127.') }.map(&:ip_address).uniq
                  rescue => e
                    warn "[!] Socket.ip_address_list error: #{e.class}: #{e.message}"
                    interfaces = []
                  end
                end

                # Fallback for non-root or failed socket
                if interfaces.empty?
                  ips = []

                  begin
                    ip_out = `ip -4 -o addr show 2>/dev/null`.to_s
                    ip_out.each_line do |line|
                      m = line.match(/\binet\s+(\d+\.\d+\.\d+\.\d+)\/\d+/)
                      ips << m[1] if m
                    end
                  rescue => ex
                    warn "[!] Fallback (ip) failed: #{ex.class}: #{ex.message}"
                  end

                  if ips.empty?
                    begin
                      host_out = `hostname -I 2>/dev/null`.to_s.strip
                      ips = host_out.split(/\s+/) unless host_out.empty?
                    rescue => ex
                      warn "[!] Fallback (hostname -I) failed: #{ex.class}: #{ex.message}"
                    end
                  end

                  interfaces = ips.empty? ? [beef_host] : ips.uniq
                end
              else
                interfaces = [beef_host]
              end
            rescue Errno::EACCES => e
              warn "[!] Warning: cannot read network interfaces (#{e.message}). Using configured host."
              interfaces = [beef_host]
            rescue => e
              warn "[!] Unexpected error reading network interfaces (#{e.class}: #{e.message}). Using configured host."
              interfaces = [beef_host]
            end

            self.interfaces = interfaces
            print_info "#{interfaces.count} network interfaces were detected."
          end

          #
          # Prints the route to the network interfaces beef has been deployed on.
          #
          def print_network_interfaces_routes
            configuration = BeEF::Core::Configuration.instance
            proto = configuration.local_proto
            hook_file = configuration.hook_file_path
            admin_ui = configuration.get('beef.extension.admin_ui.enable') ? true : false
            admin_ui_path = configuration.get('beef.extension.admin_ui.base_path')

            interfaces.each do |host|
              print_info "running on network interface: #{host}"
              port = configuration.local_port
              data = "Hook URL: #{proto}://#{host}:#{port}#{hook_file}\n"
              data += "UI URL:   #{proto}://#{host}:#{port}#{admin_ui_path}/panel\n" if admin_ui
              print_more data
            end

            if configuration.public_enabled?
              print_info 'Public:'
              data = "Hook URL: #{configuration.hook_url}\n"
              data += "UI URL:   #{configuration.beef_url_str}#{admin_ui_path}/panel\n" if admin_ui
              print_more data
            end
          end

          #
          # Print loaded extensions
          #
          def print_loaded_extensions
            extensions = BeEF::Extensions.get_loaded
            print_info "#{extensions.size} extensions enabled:"
            output = extensions.map { |_k, ext| ext['name'] }.join("\n")
            print_more output
          end

          #
          # Print loaded modules
          #
          def print_loaded_modules
            print_info "#{BeEF::Modules.get_enabled.count} modules enabled."
          end

          #
          # Print WebSocket servers
          #
          def print_websocket_servers
            config = BeEF::Core::Configuration.instance
            ws_poll_timeout = config.get('beef.http.websocket.ws_poll_timeout')
            print_info "Starting WebSocket server ws://#{config.beef_host}:#{config.get('beef.http.websocket.port').to_i} [timer: #{ws_poll_timeout}]"
            if config.get('beef.http.websocket.secure')
              print_info "Starting WebSocketSecure server wss://#{config.beef_host}:#{config.get('beef.http.websocket.secure_port').to_i} [timer: #{ws_poll_timeout}]"
            end
          end

          #
          # Print HTTP Proxy
          #
          def print_http_proxy
            config = BeEF::Core::Configuration.instance
            print_info "HTTP Proxy: http://#{config.get('beef.extension.proxy.address')}:#{config.get('beef.extension.proxy.port')}"
          end

          #
          # Print DNS info (disabled by default)
          #
          def print_dns
            address = nil
            port = nil
            protocol = nil

            unless address.nil? || port.nil? || protocol.nil?
              print_info "DNS Server: #{address}:#{port} (#{protocol})"
              print_more upstream_servers unless upstream_servers.empty?
            end
          end

        end
      end
    end
  end
end
