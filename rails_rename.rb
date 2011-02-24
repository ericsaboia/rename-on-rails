

class RailsRename 
	class << self
		def args()
			if (ARGV.size != 2)
				raise ArgumentError, "Você deve passar dois parametros: path_da_app novo_nome_app"
			end

			ARGV[0] += '/' unless ARGV[0].end_with? '/'
			ARGV[0].match(/.*(^|\/)(.*)\/$/) 

			{:path => ARGV[0], :new_name => ARGV[1],	:old_name => $2.capitalize}
		end

		def inside_files(files_path, old_name, new_name)
			files_path.each do |file_path|
				data = File.new(file_path).read
				new_data = data.gsub(/#{old_name}/, new_name.capitalize)

				File.open(file_path, 'w') {|f| f.write(new_data) } unless data == new_data
			end
		end
	end
end

args = RailsRename.args
files_path = Dir["#{args[:path]}**/**{.rb,.ru}"]

RailsRename.inside_files(files_path, args[:old_name], args[:new_name])
File.rename(args[:path], args[:new_name])

puts "Projeto #{args[:old_name]} renomeado com sucesso para #{args[:new_name].capitalize}"
