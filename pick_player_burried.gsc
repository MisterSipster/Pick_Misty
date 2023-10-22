// Custom GSC script to always be Misty on buried
#include maps\mp\zm_buried;
#include common_scripts\utility;

main()
{
	replaceFunc(maps\mp\zm_buried::assign_lowest_unused_character_index, ::assign_player);
}

assign_player()
{
    charindexarray = [];
    charindexarray[0] = 0;
    charindexarray[1] = 1;
    charindexarray[2] = 2;
    charindexarray[3] = 3;
    players = get_players();

    if ( players.size == 1 )
    {
		// 0 = Russman, 1 = Reporter, 2 = Misty, 3 = Engineer
        return 2;
    }
    else
    {
        n_characters_defined = 0;

        foreach ( player in players )
        {
            if ( isdefined( player.characterindex ) )
            {
                arrayremovevalue( charindexarray, player.characterindex, 0 );
                n_characters_defined++;
            }
        }

        if ( charindexarray.size > 0 )
        {
            if ( n_characters_defined == players.size - 1 )
            {
                if ( !( isdefined( level.has_weasel ) && level.has_weasel ) )
                {
                    level.has_weasel = 1;
                    return 3;
                }
            }

            charindexarray = array_randomize( charindexarray );

            if ( charindexarray[0] == 3 )
                level.has_weasel = 1;

            return charindexarray[0];
        }
    }

    return 0;
}
