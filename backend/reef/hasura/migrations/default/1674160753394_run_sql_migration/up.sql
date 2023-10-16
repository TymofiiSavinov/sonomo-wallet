CREATE OR REPLACE VIEW "public"."mad_feed_user_score_totals" AS 
 SELECT auth.users.id as user_id,
     COALESCE(mad_feed_user_promo_post_sums.promoted_total, 0) 
    + COALESCE(sum(mad_feed_post_vote_sums.votes), (0)::numeric)
        as total_score,
    COALESCE(sum(mad_feed_post_vote_sums.votes), (0)::numeric) AS total_post_votes_score,
    COALESCE(mad_feed_user_promo_post_sums.promoted_total, 0) AS total_promoted_score
   FROM auth.users 
    LEFT JOIN mad_feed_post_vote_sums ON (auth.users.id = mad_feed_post_vote_sums.user_id)
    LEFT JOIN mad_feed_user_promo_post_sums ON (auth.users.id = mad_feed_user_promo_post_sums.user_id)
  GROUP BY auth.users.id, mad_feed_user_promo_post_sums.promoted_total;
