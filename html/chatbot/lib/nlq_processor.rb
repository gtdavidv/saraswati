module NlqProcessor #Note that for this to work lib has to be included in the config/application.rb file
	#require "net/http" #Will be used later to open an http request
	#require "uri" #Will be used later to open an http request
	require 'json'
	require 'engtagger'
	#See tags at https://github.com/yohasebe/engtagger
	#Example output: this/DET is/VBZ a/DET sample/NN output/NN
	
	#def http_request(uri)
	#	Net::HTTP.start(uri.host, uri.port) do |http|
	#		yield(http, uri)
	#	end
	#end
	
	def generate_response(userMsg)
		returnString = ''
		queryType = determine_query_type(userMsg)
		if queryType == 'interrogative'
			returnString = find_answer(userMsg)
		elsif queryType == 'command'
			returnString += 'Command'
		elsif queryType == 'statement'
			returnString += 'Statement'
		elsif queryType == 'interjection'
			returnString += 'Interjection'
		else
			returnString += 'Sorry, what?'
		end
		
		returnString
	end
	
	def strip_query(query)
		#Currently stripping out all punctuation. More advanced understanding will require it, but works for now
		#Words being stripped out need to be checked to make sure they aren't part of a larger word (e.g., "pleased" becomes "d")
		stripArray = ['please', 'can you', 'will you', 'well', '!', '?', '.', ','] #Words/characters that will be stripped because they don't mean anything
		
		strippedQuery = query.downcase #Convert query entirely to lower case and store as strippedQuery
		stripArray.each do |stripWord| #Iterate through each element in stripArray (refer to as "stripWord")
			strippedQuery = strippedQuery.gsub(stripWord, '') #Remove the current stripWord from strippedQuery
		end
		
		return strippedQuery
	end
	
	def determine_query_type(query)
		returnString = ''
		interrogativeArray = ['who', 'what', 'when', 'where', 'why', 'how', 'which', 'whose'] #Words that will be matched for interrogatives
		commandArray = ['tell', 'explain', 'elaborate', 'say'] #Words that will be matched for commands
		interjectionArray = ['wow', 'damn', 'shit', 'fuck', 'oh', 'cool'] #Words that will be matched for interjections

		strippedQuery = strip_query(query)
		
		splitArray = strippedQuery.split(' ') #Split the stripped query into an array separated by spaces
		if interrogativeArray.include? splitArray[0]
			returnString += 'interrogative'
		elsif commandArray.include? splitArray[0]
			returnString += 'command'
		elsif interjectionArray.include? strippedQuery.strip
			returnString += 'interjection'
		else
			tgr = EngTagger.new
			#resultOutput = tgr.add_tags(query) #Uses <tag></tag> notation
			resultOutput = tgr.get_readable(strippedQuery) #Uses /TAG notation
			splitArray2 = resultOutput.split(' ')
			splitWord = splitArray2[0].split('/')
			if splitWord[1][0,1] == 'V'
				returnString += 'command'
			else
				returnString += 'other'
			end
		end
		
		returnString
	end
	
	def find_answer(query)
		returnString = ''
		@nodes = Node.none
		
		strippedQuery = strip_query(query)
		
		tgr = EngTagger.new
		resultOutput = tgr.get_readable(strippedQuery) #Uses /TAG notation
		splitArray = resultOutput.split(' ')
		splitArray.each do |term|
			splitWord = term.split('/')
			if splitWord[1][0,1] == 'N' #Is noun?
				#The idea here is to try to find the most relevant content possible
				#Search should start with immediate proximity to current node
				#Need to think about how to search relationships vs. nuggets
				@nodes = @nodes + Node.where("nugget LIKE :search_string", {:search_string => "%#{splitWord[0]}%"})
			end
		end
		
		@nodes.each do |node|
			returnString += node.nugget + ' '
		end
		
		if returnString == ''
			returnString = 'What?'
		end
		
		returnString
	end
end