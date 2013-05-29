# coding: utf-8
require 'open-uri'

namespace :import do
  task :deputies => :environment do
    page = Nokogiri::XML(open("http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados"))
    page.css("deputado").each do |deputado|
      name = deputado.css("nome").text
      puts "Fetching deputy #{name}"

      nickname = deputado.css("nomeParlamentar").text
      next if nickname == "JORGE BOEIRA"
      next if nickname == "FRANCISCO TENÓRIO"
      next if nickname == "PAULÃO"
      next if nickname == "LUIZ DE DEUS"
      next if nickname == "MARGARIDA SALOMÃO"
      next if nickname == "NILMÁRIO MIRANDA"
      next if nickname == "RENATO ANDRADE"
      next if nickname == "EURICO JÚNIOR"
      next if nickname == "MANUEL ROSA NECA"
      next if nickname == "FABIO REIS"
      next if nickname == "OLIVEIRA FILHO"
      next if nickname == "FRANCISCO CHAGAS"
      next if nickname == "LEOMAR QUINTANILHA"
      next if nickname == "CELSO JACOB"
      next if nickname == "PLÍNIO VALÉRIO"
      next if nickname == "RICARDO ARRUDA"
      next if nickname == "ILÁRIO MARQUES"
      next if nickname == "AKIRA OTSUBO"
      next if nickname == "GOIACIARA CRUZ"
      next if Deputy.find_all_by_nickname(nickname).any?
      party = Party.find_or_create_by_name(name: deputado.css("partido").text)
      state = deputado.css("uf").text

      date = Date.today - 1.month
      deputy_page = Nokogiri::HTML(open("http://www2.camara.leg.br/transparencia/cota-para-exercicio-da-atividade-parlamentar/verba_indenizatoria_retPesquisaDep?listaDep=#{Rack::Utils.escape nickname}%7C#{party.name}%7C#{state}&mesAno=#{date.month}%2F#{date.year}"))
      uid = deputy_page.css("div.listaAcoes").css("a")[0]['href'].match(/nuDeputadoId\=(\d*)/)[1]

      Deputy.create name: name, party: party, uid: uid, state: state, nickname: nickname
    end
  end

  task :refunds, [:month, :year] => :environment do |t, args|
    args.with_defaults(month: Date.today.month, year: Date.today.year)
    month = args.month
    year = args.year
    Deputy.all.each do |deputy|
      puts "Fetching refunds of #{deputy.name}..."
      page = Nokogiri::XML(open("http://www2.camara.leg.br/transparencia/cota-para-exercicio-da-atividade-parlamentar/verba_indenizatoria_detalheVerbaAnalitico?nuDeputadoId=#{deputy.uid}&numMes=#{month}&numAno=#{year}&numSubCota="))

      page.css(".grid-cell").each do |table|
        category = Category.find_or_create_by_name(name: table.css("h4.header").text)
        table.css("tbody.coresAlternadas").each do |row|
          company_cnpj = row.css("td")[0].text
          company_name = row.css("td")[1].text
          invoice = row.css("td")[2].text.delete("\n ")
          value = row.css("td")[3].text.delete("R$ ", ".").gsub(",", ".").to_f
          next if company_cnpj.blank? || invoice.blank?
          company = Company.find_or_create_by_cnpj(cnpj: company_cnpj, name: company_name)
          Refund.create company: company, invoice: invoice, deputy: deputy, value: value, category: category
        end
      end
    end
  end
end
