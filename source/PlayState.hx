package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	var player:FlxSprite;
	var testObjectGroup:FlxGroup;
	var testObjects:Array<FlxSprite>;

	override public function create():Void
	{
		FlxG.worldDivisions = 1;

		testObjectGroup = new FlxGroup();
		testObjects = new Array();

		var spacing = 30;
		var playerSize = 20;
		var objSize = 40;
		var objX:Float = ((FlxG.width - objSize) / 2) - objSize - spacing;
		var objY:Float = ((FlxG.height - objSize) / 2) - objSize - spacing;
		var lineStyle:LineStyle = {color: 0xFFFFFFFF, thickness: 1};

		for (i in 0...9)
		{
			if (i % 3 == 0)
				objX = ((FlxG.width - objSize) / 2) - objSize - spacing;
			else if ((i - 1) % 3 == 0)
				objX = ((FlxG.width - objSize) / 2);
			else if ((i - 2) % 3 == 0)
				objX = ((FlxG.width - objSize) / 2) + objSize + spacing;

			if (i == 3 || i == 6)
				objY += (objSize + spacing);

			testObjects[i] = new FlxSprite(objX, objY).makeGraphic(objSize, objSize, 0xFF666666, true);

			if ((i - 1) % 3 == 0)
				FlxSpriteUtil.drawLine(testObjects[i], objSize / 2, 0, objSize / 2, objSize, lineStyle);

			if (i > 2 && i < 6)
				FlxSpriteUtil.drawLine(testObjects[i], 0, objSize / 2, objSize, objSize / 2, lineStyle);

			testObjectGroup.add(testObjects[i]);
		}

		add(testObjectGroup);

		player = new FlxSprite((FlxG.width / 2) - (playerSize / 2), (FlxG.height / 2) - (playerSize / 2)).makeGraphic(playerSize, playerSize, 0xFF00CCCC);
		player.maxVelocity.set(100, 100);

		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.overlap(player, testObjectGroup, test);

		player.velocity.set(0, 0);

		if (FlxG.keys.pressed.LEFT)
			player.velocity.x = -player.maxVelocity.x;

		if (FlxG.keys.pressed.RIGHT)
			player.velocity.x = player.maxVelocity.x;

		if (FlxG.keys.pressed.UP)
			player.velocity.y = -player.maxVelocity.y;

		if (FlxG.keys.pressed.DOWN)
			player.velocity.y = player.maxVelocity.y;

		if (player.x < 0)
			player.x = 0;

		if (player.x + player.width > FlxG.width)
			player.x = FlxG.width - player.width;

		if (player.y < 0)
			player.y = 0;

		if (player.y + player.height > FlxG.height)
			player.y = FlxG.height - player.height;
	}

	private function test(obj1:FlxObject, obj2:FlxObject):Void
	{
		if (FlxG.keys.justPressed.ENTER)
			trace("justPressed");
	}
}
