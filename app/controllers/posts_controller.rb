class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	#this shows all posts
	def index
		@posts = Post.all.order('created_at DESC')
	end

	#displays form for new post
	def new
		@post = Post.new
	end

	#looking for specific posts in the database and diplay them
	def show
		@post = Post.find(params[:id])
	end

	#creating new post
	def create
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	#editing exising post
	def edit
		@post = Post.find(params[:id])
	end

	#updating existing post
	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post
		else
			render 'edit'
		end
	end

	#destroying exisint post
	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end
end
