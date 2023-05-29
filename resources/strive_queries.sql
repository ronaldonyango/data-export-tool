-- Query to retrieve statistics for strive videos posted in groups
Strive Weekly Report,
-- Query to retrieve statistics for strive videos posted on the newsfeed.
-- Reach: Defined as any videos with more than ten seconds of watch time
SELECT
	'POST REACH' AS data_type,
	videoId,
	count(*) AS profile_count
FROM
	video_stat_collection vsc
WHERE
	videoId IN (
	'62e61f4193ec182209df01f8',
	'62a170410451492b7064a8ec',
	'60d255fc629a9910ebc6e0fd',
	'62aab53887ef4539db2dafdd',
	'62aeb9a287ef4539db2e1a62',
	'62b3eb501eb35b4a18856bff',
	'62b815101eb35b4a1885fe67',
	'62bd362e54540a0a27375b6c',
	'62c3ca6854540a0a2738fa9c',
	'62ca7dcb94cb8062d98d4608',
	'62d394e8cf831b046ecf1851',
	'62e61f4193ec182209df01f8',
	'62da4ace0e50264469410fc0',
	'62cf92c3ca43370922f99c09',
	'62f5ca36c24a473c2c4933c2',
	'62f5cceec24a473c2c493437',
	'62f5ce6dc24a473c2c493446',
	'62f5d01fc24a473c2c49345e',
	'6322a6d08239fb3d3330abf6',
	'632beb6cc811ae40957c04d5',
	'63344dc0459b566f27aab167',
	'633d4e3b650d8336f7318beb',
	'630862bea6ac143c2b0f1a9d',
	'63677ba460a530173d59cd8a',
	'6437e45c2c010f62f696ba9e',
	'644b888caf80cf2953238bf5',
	'64468fb7b19eda068d5e8bcb'
)
	AND tenSec = 'true'
GROUP BY
	videoId
UNION
-- Query to retrieve statistics for strive videos posted on the newsfeed.
-- Deep engagement: Defined as any videos with more than ninety seconds of watch time
SELECT
	'POST DEEP ENGAGEMENT' AS data_type,
	videoId,
	count(*) AS profile_count
FROM
	video_stat_collection vsc
WHERE
	videoId IN (
	'62e61f4193ec182209df01f8',
	'62a170410451492b7064a8ec',
	'60d255fc629a9910ebc6e0fd',
	'62aab53887ef4539db2dafdd',
	'62aeb9a287ef4539db2e1a62',
	'62b3eb501eb35b4a18856bff',
	'62b815101eb35b4a1885fe67',
	'62bd362e54540a0a27375b6c',
	'62c3ca6854540a0a2738fa9c',
	'62ca7dcb94cb8062d98d4608',
	'62d394e8cf831b046ecf1851',
	'62e61f4193ec182209df01f8',
	'62da4ace0e50264469410fc0',
	'62cf92c3ca43370922f99c09',
	'62f5ca36c24a473c2c4933c2',
	'62f5cceec24a473c2c493437',
	'62f5ce6dc24a473c2c493446',
	'62f5d01fc24a473c2c49345e',
	'6322a6d08239fb3d3330abf6',
	'632beb6cc811ae40957c04d5',
	'63344dc0459b566f27aab167',
	'633d4e3b650d8336f7318beb',
	'630862bea6ac143c2b0f1a9d',
	'63677ba460a530173d59cd8a',
	'6437e45c2c010f62f696ba9e',
	'644b888caf80cf2953238bf5',
	'64468fb7b19eda068d5e8bcb'
	)
	AND sixtySec = 'true'
GROUP BY videoId
UNION
SELECT
	'GROUP VIDEO WATCHES' AS data_type,
	videoId,
	count(*) AS profile_count
FROM
	video_stat_collection vsc
WHERE
	videoId IN
('62f5ca36c24a473c2c4933c2',
'62f5cceec24a473c2c493437',
'62f5ce6dc24a473c2c493446',
'62f5d01fc24a473c2c49345e',
'6322e6e3f43f3c2169236f38',
'6322e28cf43f3c2169236e2a',
'6322dd6ff43f3c2169236d59',
'632be773c811ae40957c04a8')
GROUP BY
	videoId
UNION
-- Query to retrieve comment statistics for strive learn videos posted in groups
SELECT * FROM (
SELECT
	'GROUP POSTS COMMENTS' AS data_type,
	postId AS videoId ,
	count(*) profile_count
FROM
	z_activity_log zal
WHERE
	PostId IN
	(
	'6322e6e3f43f3c2169236f38',
	'6322e28cf43f3c2169236e2a',
	'6322dd6ff43f3c2169236d59',
	'632be773c811ae40957c04a8',
	'633517ed459b566f27aad23d',
	'6335163d534c4c4e8342e459',
	'6335141a534c4c4e8342e442',
	'633e1bb3650d8336f731c499',
	'633e1fdbe4e81a704d708b6c',
	'633e1e00650d8336f731e68b',
	'6354e60e4e4a460737ee4e30',
	'6354e4dd7d79c2716fcc79ce',
	'6354e2904e4a460737ee2df0',
	'63873a1f29c88d2d537e276c',
	'638738c929c88d2d537e158b',
	'638735a5db4d110f13f2abdf',
	'63cf9ab14d0ddc473c393bce',
	'63cf986699dc7724b9ede324',
	'63cf9e1e99dc7724b9ee0170',
	'63db75895e4f431ea5660882',
	'63db774a99d4aa256d99e4f5',
	'63db78c35e4f431ea5660892',
	'63edf644b7a14159b35ae7d1',
	'63edf82fda731577b5e7512b',
	'63edf95ada731577b5e7514d',
	'63edfa9bda731577b5e75199',
	'63f6016ad8fbeb2d60ab777b',
	'63f6005cda731577b5e8b6de',
	'6437d13904f9bf0eee0a2288',
	'6437d2f804f9bf0eee0a22b5',
	'6437d46d04f9bf0eee0a22d6'
	) AND event_type = 'comment'
GROUP BY
	postId ,
	event_type
ORDER BY
	field
	(postId,
	'6322e28cf43f3c2169236e2a',
	'6322dd6ff43f3c2169236d59',
	'632be773c811ae40957c04a8',
	'633517ed459b566f27aad23d',
	'6335163d534c4c4e8342e459',
	'6335141a534c4c4e8342e442',
	'633e1bb3650d8336f731c499',
	'633e1fdbe4e81a704d708b6c',
	'633e1e00650d8336f731e68b',
	'6354e60e4e4a460737ee4e30',
	'6354e4dd7d79c2716fcc79ce',
	'6354e2904e4a460737ee2df0',
	'63873a1f29c88d2d537e276c',
	'638738c929c88d2d537e158b',
	'638735a5db4d110f13f2abdf',
	'63cf9ab14d0ddc473c393bce',
	'63cf986699dc7724b9ede324',
	'63cf9e1e99dc7724b9ee0170',
	'63db75895e4f431ea5660882',
	'63db774a99d4aa256d99e4f5',
	'63db78c35e4f431ea5660892',
	'63edf644b7a14159b35ae7d1',
	'63edf82fda731577b5e7512b',
	'63edf95ada731577b5e7514d',
	'63edfa9bda731577b5e75199',
	'63f6016ad8fbeb2d60ab777b',
	'63f6005cda731577b5e8b6de',
	'6437d13904f9bf0eee0a2288',
	'6437d2f804f9bf0eee0a22b5',
	'6437d46d04f9bf0eee0a22d6'
	)) AS videos_comments
UNION
-- Query to retrieve reactions statistics for strive videos posted in groups
SELECT * FROM (
SELECT
	'GROUP POSTS REACTIONS' AS data_type,
	postId AS videoId ,
	count(*) AS profile_count
FROM
	z_activity_log zal
WHERE
	PostId IN
	(
	'6322e6e3f43f3c2169236f38',
	'6322e28cf43f3c2169236e2a',
	'6322dd6ff43f3c2169236d59',
	'632be773c811ae40957c04a8',
	'633517ed459b566f27aad23d',
	'6335163d534c4c4e8342e459',
	'6335141a534c4c4e8342e442',
	'633e1bb3650d8336f731c499',
	'633e1fdbe4e81a704d708b6c',
	'633e1e00650d8336f731e68b',
	'6354e60e4e4a460737ee4e30',
	'6354e4dd7d79c2716fcc79ce',
	'6354e2904e4a460737ee2df0',
	'63873a1f29c88d2d537e276c',
	'638738c929c88d2d537e158b',
	'638735a5db4d110f13f2abdf',
	'63cf9ab14d0ddc473c393bce',
	'63cf986699dc7724b9ede324',
	'63cf9e1e99dc7724b9ee0170',
	'63db75895e4f431ea5660882',
	'63db774a99d4aa256d99e4f5',
	'63db78c35e4f431ea5660892',
	'63edf644b7a14159b35ae7d1',
	'63edf82fda731577b5e7512b',
	'63edf95ada731577b5e7514d',
	'63edfa9bda731577b5e75199',
	'63f6016ad8fbeb2d60ab777b',
	'63f6005cda731577b5e8b6de',
	'6437d13904f9bf0eee0a2288',
	'6437d2f804f9bf0eee0a22b5',
	'6437d46d04f9bf0eee0a22d6'
	) AND event_type = 'reaction'
GROUP BY
	postId ,
	event_type
ORDER BY
	field
	(postId,
	'6322e28cf43f3c2169236e2a',
	'6322dd6ff43f3c2169236d59',
	'632be773c811ae40957c04a8',
	'633517ed459b566f27aad23d',
	'6335163d534c4c4e8342e459',
	'6335141a534c4c4e8342e442',
	'633e1bb3650d8336f731c499',
	'633e1fdbe4e81a704d708b6c',
	'633e1e00650d8336f731e68b',
	'6354e60e4e4a460737ee4e30',
	'6354e4dd7d79c2716fcc79ce',
	'6354e2904e4a460737ee2df0',
	'63873a1f29c88d2d537e276c',
	'638738c929c88d2d537e158b',
	'638735a5db4d110f13f2abdf',
	'63cf9ab14d0ddc473c393bce',
	'63cf986699dc7724b9ede324',
	'63cf9e1e99dc7724b9ee0170',
	'63db75895e4f431ea5660882',
	'63db774a99d4aa256d99e4f5',
	'63db78c35e4f431ea5660892',
	'63edf644b7a14159b35ae7d1',
	'63edf82fda731577b5e7512b',
	'63edf95ada731577b5e7514d',
	'63edfa9bda731577b5e75199',
	'63f6016ad8fbeb2d60ab777b',
	'63f6005cda731577b5e8b6de',
	'6437d13904f9bf0eee0a2288',
	'6437d2f804f9bf0eee0a22b5',
	'6437d46d04f9bf0eee0a22d6'
	)) AS group_reactions
UNION
-- Query to retrieve comment statistics for strive videos posted in Learn
SELECT * FROM (
SELECT
	'LEARN VIDEO COMMENTS' AS data_type,
	attachedId AS videoId ,
	count(*)
FROM
	z_activity_log zal
WHERE
	attachedId IN (
'629efeb09812d4124323dfee',
'629f033f9812d4124323dfef',
'629f05775da57e178b6c1ac8',
'62a2b7719812d4124323dff6',
'62a2b8ad9812d4124323dff7',
'62a2bd555da57e178b6c1adf',
'62a2bf9e9812d4124323dff8',
'62a2c2a89812d4124323dff9',
'62a2c6739812d4124323dffa',
'62a234c75da57e178b6c1add',
'62a23a529812d4124323dff4',
'62a23c3f9812d4124323dff5',
'62a23f1e5da57e178b6c1ade',
'629ef78d9812d4124323dfed',
'629efab15da57e178b6c1ac5',
'629efb8d5da57e178b6c1ac6',
'62a1d40a5da57e178b6c1ad8',
'62a1d5e65da57e178b6c1ad9',
'62a1dc7f5da57e178b6c1ada',
'62a1df439812d4124323dff2',
'62a72a795da57e178b6c1aec',
'62a839e69812d4124323e00c',
'62a83dc4ef3eec449ddd6df0',
'62a85374ef3eec449ddd6df6',
'62a85556ef3eec449ddd6df7',
'62a868f1ef3eec449ddd6df9',
'62a86b0def3eec449ddd6dfa',
'62a86ed3ef3eec449ddd6dfe',
'62a870f79812d4124323e020',
'62a98aca9812d4124323e025',
'62a9939c9812d4124323e027',
'62a99794ef3eec449ddd6e0c'
)
AND event_type = 'shujaazbiz_comments'
GROUP BY
	attachedId ,
	event_type
ORDER BY
	field(attachedId,
'629efeb09812d4124323dfee',
'629f033f9812d4124323dfef',
'629f05775da57e178b6c1ac8',
'62a2b7719812d4124323dff6',
'62a2b8ad9812d4124323dff7',
'62a2bd555da57e178b6c1adf',
'62a2bf9e9812d4124323dff8',
'62a2c2a89812d4124323dff9',
'62a2c6739812d4124323dffa',
'62a234c75da57e178b6c1add',
'62a23a529812d4124323dff4',
'62a23c3f9812d4124323dff5',
'62a23f1e5da57e178b6c1ade',
'629ef78d9812d4124323dfed',
'629efab15da57e178b6c1ac5',
'629efb8d5da57e178b6c1ac6',
'62a1d40a5da57e178b6c1ad8',
'62a1d5e65da57e178b6c1ad9',
'62a1dc7f5da57e178b6c1ada',
'62a1df439812d4124323dff2',
'62a72a795da57e178b6c1aec',
'62a839e69812d4124323e00c',
'62a83dc4ef3eec449ddd6df0',
'62a85374ef3eec449ddd6df6',
'62a85556ef3eec449ddd6df7',
'62a868f1ef3eec449ddd6df9',
'62a86b0def3eec449ddd6dfa',
'62a86ed3ef3eec449ddd6dfe',
'62a870f79812d4124323e020',
'62a98aca9812d4124323e025',
'62a9939c9812d4124323e027',
'62a99794ef3eec449ddd6e0c'
)) AS group_reactions
UNION
-- Query to retrieve reach statistics for videos posted in Learn
SELECT * FROM (
SELECT
	'LEARN VIDEOS REACH' AS data_type,
	videoId,
	count(*) AS profile_count
FROM
	video_stat_collection vsc
WHERE
	videoId IN (
'629efeb09812d4124323dfee',
'629f033f9812d4124323dfef',
'629f05775da57e178b6c1ac8',
'62a2b7719812d4124323dff6',
'62a2b8ad9812d4124323dff7',
'62a2bd555da57e178b6c1adf',
'62a2bf9e9812d4124323dff8',
'62a2c2a89812d4124323dff9',
'62a2c6739812d4124323dffa',
'62a234c75da57e178b6c1add',
'62a23a529812d4124323dff4',
'62a23c3f9812d4124323dff5',
'62a23f1e5da57e178b6c1ade',
'629ef78d9812d4124323dfed',
'629efab15da57e178b6c1ac5',
'629efb8d5da57e178b6c1ac6',
'62a1d40a5da57e178b6c1ad8',
'62a1d5e65da57e178b6c1ad9',
'62a1dc7f5da57e178b6c1ada',
'62a1df439812d4124323dff2',
'62a72a795da57e178b6c1aec',
'62a839e69812d4124323e00c',
'62a83dc4ef3eec449ddd6df0',
'62a85374ef3eec449ddd6df6',
'62a85556ef3eec449ddd6df7',
'62a868f1ef3eec449ddd6df9',
'62a86b0def3eec449ddd6dfa',
'62a86ed3ef3eec449ddd6dfe',
'62a870f79812d4124323e020',
'62a98aca9812d4124323e025',
'62a9939c9812d4124323e027',
'62a99794ef3eec449ddd6e0c'
)
	AND tenSec = 'true'
GROUP BY
	videoId
ORDER BY
	field(videoId,
'629efeb09812d4124323dfee',
'629f033f9812d4124323dfef',
'629f05775da57e178b6c1ac8',
'62a2b7719812d4124323dff6',
'62a2b8ad9812d4124323dff7',
'62a2bd555da57e178b6c1adf',
'62a2bf9e9812d4124323dff8',
'62a2c2a89812d4124323dff9',
'62a2c6739812d4124323dffa',
'62a234c75da57e178b6c1add',
'62a23a529812d4124323dff4',
'62a23c3f9812d4124323dff5',
'62a23f1e5da57e178b6c1ade',
'629ef78d9812d4124323dfed',
'629efab15da57e178b6c1ac5',
'629efb8d5da57e178b6c1ac6',
'62a1d40a5da57e178b6c1ad8',
'62a1d5e65da57e178b6c1ad9',
'62a1dc7f5da57e178b6c1ada',
'62a1df439812d4124323dff2',
'62a72a795da57e178b6c1aec',
'62a839e69812d4124323e00c',
'62a83dc4ef3eec449ddd6df0',
'62a85374ef3eec449ddd6df6',
'62a85556ef3eec449ddd6df7',
'62a868f1ef3eec449ddd6df9',
'62a86b0def3eec449ddd6dfa',
'62a86ed3ef3eec449ddd6dfe',
'62a870f79812d4124323e020',
'62a98aca9812d4124323e025',
'62a9939c9812d4124323e027',
'62a99794ef3eec449ddd6e0c'
)) AS videos_reach
UNION
-- Query to retrieve deep engagement statistics for videos posted in Learn
SELECT * FROM (
SELECT
	'LEARN VIDEOS DEEP ENGAGEMENT' AS data_type,
	videoId,
	count(*) AS profile_count
FROM
	video_stat_collection vsc
WHERE
	videoId IN (
	'629efeb09812d4124323dfee',
	'629f033f9812d4124323dfef',
	'629f05775da57e178b6c1ac8',
	'62a2b7719812d4124323dff6',
	'62a2b8ad9812d4124323dff7',
	'62a2bd555da57e178b6c1adf',
	'62a2bf9e9812d4124323dff8',
	'62a2c2a89812d4124323dff9',
	'62a2c6739812d4124323dffa',
	'62a234c75da57e178b6c1add',
	'62a23a529812d4124323dff4',
	'62a23c3f9812d4124323dff5',
	'62a23f1e5da57e178b6c1ade',
	'629ef78d9812d4124323dfed',
	'629efab15da57e178b6c1ac5',
	'629efb8d5da57e178b6c1ac6',
	'62a1d40a5da57e178b6c1ad8',
	'62a1d5e65da57e178b6c1ad9',
	'62a1dc7f5da57e178b6c1ada',
	'62a1df439812d4124323dff2',
	'62a72a795da57e178b6c1aec',
	'62a839e69812d4124323e00c',
	'62a83dc4ef3eec449ddd6df0',
	'62a85374ef3eec449ddd6df6',
	'62a85556ef3eec449ddd6df7',
	'62a868f1ef3eec449ddd6df9',
	'62a86b0def3eec449ddd6dfa',
	'62a86ed3ef3eec449ddd6dfe',
	'62a870f79812d4124323e020',
	'62a98aca9812d4124323e025',
	'62a9939c9812d4124323e027',
	'62a99794ef3eec449ddd6e0c'
)
	AND sixtySec = 'true'
GROUP BY
	videoId
ORDER BY
	field(videoId,
	'629efeb09812d4124323dfee',
	'629f033f9812d4124323dfef',
	'629f05775da57e178b6c1ac8',
	'62a2b7719812d4124323dff6',
	'62a2b8ad9812d4124323dff7',
	'62a2bd555da57e178b6c1adf',
	'62a2bf9e9812d4124323dff8',
	'62a2c2a89812d4124323dff9',
	'62a2c6739812d4124323dffa',
	'62a234c75da57e178b6c1add',
	'62a23a529812d4124323dff4',
	'62a23c3f9812d4124323dff5',
	'62a23f1e5da57e178b6c1ade',
	'629ef78d9812d4124323dfed',
	'629efab15da57e178b6c1ac5',
	'629efb8d5da57e178b6c1ac6',
	'62a1d40a5da57e178b6c1ad8',
	'62a1d5e65da57e178b6c1ad9',
	'62a1dc7f5da57e178b6c1ada',
	'62a1df439812d4124323dff2',
	'62a72a795da57e178b6c1aec',
	'62a839e69812d4124323e00c',
	'62a83dc4ef3eec449ddd6df0',
	'62a85374ef3eec449ddd6df6',
	'62a85556ef3eec449ddd6df7',
	'62a868f1ef3eec449ddd6df9',
	'62a86b0def3eec449ddd6dfa',
	'62a86ed3ef3eec449ddd6dfe',
	'62a870f79812d4124323e020',
	'62a98aca9812d4124323e025',
	'62a9939c9812d4124323e027',
	'62a99794ef3eec449ddd6e0c'
)) AS videos_engagement
UNION
-- Query to retrieve reaction statistics for strive videos posted in Learn
SELECT * FROM (
SELECT
	'LEARN VIDEO REACTIONS' AS data_type,
	attachedId AS videoId ,
	count(*)
FROM
	z_activity_log zal
WHERE
	attachedId IN (
'629efeb09812d4124323dfee',
'629f033f9812d4124323dfef',
'629f05775da57e178b6c1ac8',
'62a2b7719812d4124323dff6',
'62a2b8ad9812d4124323dff7',
'62a2bd555da57e178b6c1adf',
'62a2bf9e9812d4124323dff8',
'62a2c2a89812d4124323dff9',
'62a2c6739812d4124323dffa',
'62a234c75da57e178b6c1add',
'62a23a529812d4124323dff4',
'62a23c3f9812d4124323dff5',
'62a23f1e5da57e178b6c1ade',
'629ef78d9812d4124323dfed',
'629efab15da57e178b6c1ac5',
'629efb8d5da57e178b6c1ac6',
'62a1d40a5da57e178b6c1ad8',
'62a1d5e65da57e178b6c1ad9',
'62a1dc7f5da57e178b6c1ada',
'62a1df439812d4124323dff2',
'62a72a795da57e178b6c1aec',
'62a839e69812d4124323e00c',
'62a83dc4ef3eec449ddd6df0',
'62a85374ef3eec449ddd6df6',
'62a85556ef3eec449ddd6df7',
'62a868f1ef3eec449ddd6df9',
'62a86b0def3eec449ddd6dfa',
'62a86ed3ef3eec449ddd6dfe',
'62a870f79812d4124323e020',
'62a98aca9812d4124323e025',
'62a9939c9812d4124323e027',
'62a99794ef3eec449ddd6e0c'
)
	AND event_type = 'shujaazbiz_reactions'
GROUP BY
	attachedId ,
	event_type
ORDER BY
	field(attachedId,
'629efeb09812d4124323dfee',
'629f033f9812d4124323dfef',
'629f05775da57e178b6c1ac8',
'62a2b7719812d4124323dff6',
'62a2b8ad9812d4124323dff7',
'62a2bd555da57e178b6c1adf',
'62a2bf9e9812d4124323dff8',
'62a2c2a89812d4124323dff9',
'62a2c6739812d4124323dffa',
'62a234c75da57e178b6c1add',
'62a23a529812d4124323dff4',
'62a23c3f9812d4124323dff5',
'62a23f1e5da57e178b6c1ade',
'629ef78d9812d4124323dfed',
'629efab15da57e178b6c1ac5',
'629efb8d5da57e178b6c1ac6',
'62a1d40a5da57e178b6c1ad8',
'62a1d5e65da57e178b6c1ad9',
'62a1dc7f5da57e178b6c1ada',
'62a1df439812d4124323dff2',
'62a72a795da57e178b6c1aec',
'62a839e69812d4124323e00c',
'62a83dc4ef3eec449ddd6df0',
'62a85374ef3eec449ddd6df6',
'62a85556ef3eec449ddd6df7',
'62a868f1ef3eec449ddd6df9',
'62a86b0def3eec449ddd6dfa',
'62a86ed3ef3eec449ddd6dfe',
'62a870f79812d4124323e020',
'62a98aca9812d4124323e025',
'62a9939c9812d4124323e027',
'62a99794ef3eec449ddd6e0c'
)) AS video_reactions;
