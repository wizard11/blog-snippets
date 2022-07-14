  Future<PostModel> getPost(String postId) async {
    String postQuery = """
      query FetchPost(\$postId: ID!){
        getPost(postId: \$postId){
          id
          creator {
            ...userFragment
          }
          createdTimestamp
          image
          text
          comments{
            id
            creator{
              ...userFragment
            }
            createdTimestamp
            text
          }
          likes{
            id
            creator{
              ...userFragment
            }
            createdTimestamp
          }
        }
      }
      ${GqlFragments.UserFragment}
    """;

    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(postQuery),
        variables: {"postId": postId},
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return PostModel.fromJson(result.data[queryName]);
  }
