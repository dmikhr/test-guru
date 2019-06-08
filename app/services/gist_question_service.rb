class GistQuestionService

  def initialize(question, client = octokit_client)
    @client = client #|| GitHubClient.new
    @question = question
    @test = @question.test
  end

  def call
    @result = @client.create_gist(gist_params)
  end

  def gist_url
    @result.html_url
  end

  def success?
    gist_url.present? && gist_url.include?('https://gist.github.com/')
  end

  private

  def octokit_client
    client = Octokit::Client.new(:access_token => ENV['GITHUB_ACCESS_TOKEN'])
  end

  def gist_params
    {
      # https://stackoverflow.com/questions/33391908/how-to-use-i18n-from-controller-in-rails
      description: I18n.t('services.gist_question_service.description', title: @test.title),
      files: {
        'test_guru_question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end
