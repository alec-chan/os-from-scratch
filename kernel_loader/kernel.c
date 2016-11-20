void main()
{

	//pointer points to the first text cell of video memory (0,0)
	char* video_memory = (char*) 0xb8000;
	//write the character X to the (0,0) text cell
	*video_memory = 'X';
}
