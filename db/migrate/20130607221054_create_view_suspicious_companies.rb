class CreateViewSuspiciousCompanies < ActiveRecord::Migration
  def up
    create_view :suspicious_companies, "
    WITH deputy_stats AS (
      SELECT
        d.id AS deputy_id,
        r.company_id,
        sum(r.value) AS total_refunds
      FROM
        deputies d
        JOIN refunds r ON d.id = r.deputy_id
      GROUP BY
        d.id,
        r.company_id
      ),
      
      company_rankings AS (
      SELECT
        deputy_id,
        company_id,
        rank() OVER (PARTITION BY deputy_id ORDER BY total_refunds DESC, company_id) AS rank,
        total_refunds
      FROM 
        deputy_stats
      )
      
      SELECT * FROM company_rankings WHERE rank <= 5;
    "
  end

  def down
    drop_view :suspicious_companies
  end
end
