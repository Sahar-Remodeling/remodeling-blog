class ApplicationController < ActionController::Base

  def index
    @featured_post = CamaPost.find_by(is_feature: 1)
    @feature_image = CamaMetas.find_by(objectid: @featured_post.id, object_class: 'Post', key: 'thumb').value


    @latest_posts = CamaPost.where(status: :published).order(created_at: :desc).limit(4)

    @recommanded_id = CamaTermTaxonomy.find_by(taxonomy: :category, slug: :recommanded)
    @recommanded_posts_ids = CamaTermRelationship.where(term_taxonomy_id: @recommanded_id).pluck(:objectid)
    @recommanded_posts = CamaPost.where("id IN (?)", @recommanded_posts_ids)


    @must_id = CamaTermTaxonomy.find_by(taxonomy: :category, slug: :must)
    @must_posts_ids = CamaTermRelationship.where(term_taxonomy_id: @must_id).pluck(:objectid)
    @must_posts = CamaPost.where("id IN (?)", @must_posts_ids)

  end

  def post
    @latest_posts = CamaPost.where(status: :published).order(created_at: :desc).limit(4)
    @post = CamaPost.find_by(slug: params[:word])

    @tags = CamaTermTaxonomy.where(taxonomy: :post_tag)
    @posts_tags_ids = CamaTermRelationship.where(objectid: @post.id, term_taxonomy_id: @tags).pluck(:term_taxonomy_id)
    @post_tags = CamaTermTaxonomy.where("id IN (?)", @posts_tags_ids)

    @recommanded_posts = CamaPost.where("id IN (?)", @recommanded_posts_ids)
  end

  def topic

    @taxonomy = CamaTermTaxonomy.find(params[:id])
    @featured_post = CamaPost.find_by(is_feature: 1)
    @feature_image = CamaMetas.find_by(objectid: @featured_post.id, object_class: 'Post', key: 'thumb').value

    @latest_posts = CamaPost.where(status: :published).order(created_at: :desc).limit(4)

    @recommanded_id = CamaTermTaxonomy.find_by(taxonomy: :category, slug: :recommanded)
    @recommanded_posts_ids = CamaTermRelationship.where(term_taxonomy_id: @recommanded_id).pluck(:objectid)
    @res = CamaTermRelationship.where(term_taxonomy_id: @taxonomy).where("objectid IN (?)", @recommanded_posts_ids).pluck(:objectid)
    @recommanded_posts = CamaPost.where("id IN (?)", @res)


    @must_id = CamaTermTaxonomy.find_by(taxonomy: :category, slug: :must)
    @must_posts_ids = CamaTermRelationship.where(term_taxonomy_id: @must_id).pluck(:objectid)
    @res2 = CamaTermRelationship.where(term_taxonomy_id: @taxonomy).where("objectid IN (?)", @must_posts_ids).pluck(:objectid)
    @must_posts = CamaPost.where("id IN (?)", @res2)

  end
end
